import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:shake_tune/shake_detector.dart';

class ShakeTune extends StatefulWidget {
  final List<Widget> children;
  final List<double>? probabilities;
  final bool? firstElementShownOnlyOnce;
  final bool? alwaysChooseDifferentElement;
  final VoidCallback? callback;

  /// Creates a ShakeTune widget.
  ///
  /// On shake randomly chooses one element from the [children] array.
  ///
  /// If the [probabilities] array (the length shall be equal to length of the
  /// [children] array, and the sum of all elements shall be equal to one)
  /// is not provided probabilities of choosing one element distributed evenly,
  /// if the [probabilities] array provide widget use chances from probabilities
  /// array.
  ///
  /// The [children] parameter must not be null.
  ///
  /// The [callback] called when phone shook.
  ///
  /// The [firstElementShownOnlyOnce] property defines if first element shows
  /// only on first start (before shake).
  /// The [alwaysChooseDifferentElement] property defines if we should choose
  /// different element on every shake.
  const ShakeTune({
    super.key,
    required this.children,
    this.probabilities,
    this.callback,
    this.firstElementShownOnlyOnce,
    this.alwaysChooseDifferentElement,
  });

  @override
  State<ShakeTune> createState() => _ShakeTuneState();
}

class _ShakeTuneState extends State<ShakeTune> {
  int indexToShow = 0;

  void validateProbabilities () {
    if (widget.probabilities != null) {
      double probabilitiesSum = widget.probabilities!.reduce((value, element) => value + element);

      if (probabilitiesSum.toStringAsFixed(2) != '1.00') {
        throw Exception('Probabilities array must have sum of its elements equal to 1');
      }

      if (widget.firstElementShownOnlyOnce == true && widget.probabilities!.length == widget.children.length - 1) {
        return;
      } else if (widget.firstElementShownOnlyOnce == true) {
        throw Exception('Probabilities array must have the same number of elements as children array minus one if showFirstElementOnlyOnce is true');
      }

      if (widget.probabilities!.length != widget.children.length) {
        throw Exception('Probabilities array must have the same number of elements as children array');
      }
    }
  }

  int pickOneWithGivenProbability (int maxIndex, List<double> probabilities) {
    double rand = Random().nextDouble();
    double cumulativeProbability = 0.0;

    for (int i = 0; i < maxIndex; i++) {
      cumulativeProbability += probabilities[i];
      if (rand < cumulativeProbability) {
        return i;
      }
    }

    return -1;
  }

  int pickOneWithFunction (
    int previousValue,
    bool alwaysChangeGeneration,
    Function random,
    {int depth = 0}
  ) {
    if (depth == 20) {
      throw Exception('Finding new not repeating element stopped, recursion stopped');
    }

    int generated = random();
    if (generated == previousValue && alwaysChangeGeneration == true) {
      return pickOneWithFunction(previousValue, alwaysChangeGeneration, random, depth: depth+1);
    }
    return generated;
  }

  void handleShake () {
    int lowerBound = widget.firstElementShownOnlyOnce == true ? 1 : 0;
    int upperBound = widget.firstElementShownOnlyOnce == true ? widget.children.length-1 : widget.children.length;

    if (widget.probabilities != null) {
      setState(() {
        indexToShow = pickOneWithFunction(
          indexToShow,
          widget.alwaysChooseDifferentElement == null ? false : widget.alwaysChooseDifferentElement!,
          () {
            return pickOneWithGivenProbability(upperBound, widget.probabilities!) + lowerBound;
          }
        );
      });
    } else {
      setState(() {
        indexToShow = pickOneWithFunction(
          indexToShow,
          widget.alwaysChooseDifferentElement == null ? false : widget.alwaysChooseDifferentElement!,
          () {
            return Random().nextInt(upperBound) + lowerBound;
          }
        );
      });
    }

    if (widget.callback != null) {
      widget.callback!();
    }
  }

  late final ShakeDetector shakeDetector;

  @override
  void initState() {
    super.initState();

    validateProbabilities();

    shakeDetector = ShakeDetector.autoStart(onPhoneShake: handleShake);
  }

  @override
  void dispose() {
    shakeDetector.stopListening();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ShakeTune oldWidget) {
    shakeDetector.changeCallback(handleShake);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(duration: Duration(milliseconds: 100), child: widget.children[indexToShow],);
  }
}
