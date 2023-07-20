import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shake_tune/shake_tune.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool animationFlag = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('YOU WON:', style: TextStyle(fontSize: 21.0),),
               ShakeTune(
                  probabilities: const [0.2, 0.2, 0.2, 0.2, 0.2],
                  alwaysChooseDifferentElement: true,
                  firstElementShownOnlyOnce: true,
                  callback: () {
                    setState(() {
                      animationFlag = !animationFlag;
                    });
                  },
                  children: [
                    prizeItem('Shake your phone', Icons.edgesensor_high_rounded),
                    prizeItem('Car', Icons.directions_car_rounded),
                    prizeItem('House', Icons.house_rounded),
                    prizeItem('100 ₽ balance top up', Icons.currency_ruble),
                    prizeItem('Console', Icons.games_rounded),
                    prizeItem('- 7000 ₽ fire alarm penalty', Icons.fire_extinguisher_rounded),
                  ]),

            ],
          ),
        )),
    );
  }

  Widget prizeItem(String text, IconData icon) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ShakeAnimation(child: child);
        },
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          if (currentChild != null) {
            return currentChild;
          }
          return const Text('Error');
        },
        child:Column(key: ValueKey<bool>(animationFlag), children: [
          Icon(icon, color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), size: 250.0),
          Text(text)
        ]));
  }
}

class ShakeAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const ShakeAnimation({super.key, required this.child, this.duration = const Duration(milliseconds: 500)});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(sin(value * pi * 10) * 10, 0.0),
          child: child,
        );
      },
      child: child,
    );
  }
}
