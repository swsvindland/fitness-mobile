import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class All extends StatelessWidget {
  const All({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: const Align(
        alignment: Alignment.topCenter,
        child: Text("All"),
      ),
    );
  }
}
