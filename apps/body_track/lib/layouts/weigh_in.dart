import 'package:body_track/widgets/weigh_in_form.dart';
import 'package:flutter/material.dart';
import 'package:utils/constants.dart';

class WeighIn extends StatefulWidget {
  const WeighIn({super.key});

  @override
  State<WeighIn> createState() => _WeighInState();
}

class _WeighInState extends State<WeighIn> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Weigh In"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: WeighInForm()
        ),
      ),
    );
  }
}
