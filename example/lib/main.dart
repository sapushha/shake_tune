import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ShakeTune(
        callback: () {
          setState(() {});
        },
        child: Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: ColoredBox(
              color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
              child: Text('text'),
            ),
          ),
        ),
      )),
    );
  }
}
