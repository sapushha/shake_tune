import 'package:flutter/widgets.dart';
import 'package:shake_tune/shake_detector.dart';

class ShakeTune extends StatefulWidget {
  final Widget child;
  final VoidCallback callback;

  const ShakeTune({super.key, required this.child, required this.callback});

  @override
  State<ShakeTune> createState() => _ShakeTuneState();
}

class _ShakeTuneState extends State<ShakeTune> {
  late final ShakeDetector shakeDetector;
  @override
  void initState() {
    shakeDetector = ShakeDetector.autoStart(onPhoneShake: widget.callback);
    super.initState();
  }

  @override
  void dispose() {
    shakeDetector.stopListening();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ShakeTune oldWidget) {
    if (oldWidget.child != widget.child) {
      setState(() {});
    }
    if (oldWidget.callback != widget.callback) {
      shakeDetector.changeCallback(widget.callback);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
