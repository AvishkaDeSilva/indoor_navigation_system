import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import '../utilities/styles.dart';
import 'login_screen.dart';

class InitialScreen extends StatefulWidget {
  static const String id = 'initial_screen';
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    _controller.forward();

    delayScreen();
  }

  delayScreen() {
    var duration = const Duration(seconds: 7);
    _timer = Timer(
        duration, () => Navigator.pushReplacementNamed(context, LoginScreen.id));
    return _timer;
  }

  @override
  void dispose() {
    if (mounted) {
      _controller.dispose();
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, LoginScreen.id),
      child: Scaffold(
        backgroundColor: initialScreenBC,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                flex: 4,
                child: SizedBox(
                  height: 300.0,
                  child: FadeTransition(
                      opacity: _animation,
                      child: Hero(
                          tag: 'logo',
                          child: Image.asset('assets/images/logo.jpg'))),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Flexible(
                flex: 1,
                child: Center(
                  child: DelayedDisplay(
                    delay: Duration(seconds: 3),
                    child: Text(
                      displayName,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
