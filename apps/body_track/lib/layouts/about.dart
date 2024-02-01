import 'package:body_track/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:body_track/utils/constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('About'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Designed and Built by',
                style: TextStyle(color: secondary, fontSize: 16),
              ),
              Text(
                'Sam Svindland',
                style: TextStyle(color: ternary, fontSize: 12),
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                'Version',
                style: TextStyle(color: secondary, fontSize: 16),
              ),
              Text(
                '1.10.0',
                style: TextStyle(color: ternary, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
