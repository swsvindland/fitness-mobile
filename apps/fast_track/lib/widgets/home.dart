import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const FastDisplay();
  }
}

class FastDisplay extends StatefulWidget {
  const FastDisplay({super.key});

  @override
  State<FastDisplay> createState() => _FastDisplayState();
}

class _FastDisplayState extends State<FastDisplay> {
  DateTime? fastStart;
  DateTime? now;
  int seconds = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      var newNow = DateTime.now();
      setState(() {
        now = newNow;
        seconds = fastStart != null ? newNow.difference(fastStart!).inSeconds : 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Fast Display'),
        fastStart != null && now != null
            ? Text(seconds.toString())
            : const Text(''),
        FilledButton(
          onPressed: () {
            setState(() {
              fastStart = DateTime.now();
            });
          },
          child: const Text('Start'),
        ),
        FilledButton(
          onPressed: () {
            setState(() {
              fastStart = null;
            });
          },
          child: const Text('Stop'),
        ),
      ],
    );
  }
}
