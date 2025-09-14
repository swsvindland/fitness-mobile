import 'package:body_track/widgets/progress_photos_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProgressPhotosAddPage extends StatefulWidget {
  const ProgressPhotosAddPage({super.key});

  @override
  State<ProgressPhotosAddPage> createState() => _ProgressPhotosAddPageState();
}

class _ProgressPhotosAddPageState extends State<ProgressPhotosAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add Progress Photos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: const ProgressPhotosForm(),
    );
  }
}
