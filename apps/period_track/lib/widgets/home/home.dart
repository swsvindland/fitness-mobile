import 'package:flutter/material.dart';
import 'package:utils/constants.dart';
import 'home_desktop.dart';
import 'home_mobile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < sm) {
      return const HomeMobile();
    }

    return const HomeDesktop();
  }
}
