import 'dart:io';

import 'package:body_track/services/progress_photos_repository.dart' as local_repo;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgressPhotosList extends StatefulWidget {
  const ProgressPhotosList({super.key});

  @override
  State<ProgressPhotosList> createState() => _ProgressPhotosListState();
}

class _ProgressPhotosListState extends State<ProgressPhotosList> {
  final _repo = local_repo.ProgressPhotosRepository();
  late Future<List<local_repo.ProgressPhotoEntry>> _future;

  @override
  void initState() {
    super.initState();
    _future = _repo.loadEntries();
  }

  Future<void> _reload() async {
    setState(() {
      _future = _repo.loadEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<local_repo.ProgressPhotoEntry>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'No progress photos yet. Tap the + button to add your first set.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: _reload,
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final e = items[index];
              return Dismissible(
                key: ValueKey(e.id),
                background: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) async {
                  return await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Delete entry?'),
                          content: const Text('This will remove the photos from the app. This action cannot be undone.'),
                          actions: [
                            TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
                            TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Delete')),
                          ],
                        ),
                      ) ??
                      false;
                },
                onDismissed: (_) async {
                  await _repo.deleteEntry(e.id);
                  _reload();
                },
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(DateFormat.yMMMd().format(e.date), style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Row(
                        children: [
                          Expanded(child: _thumb(e.frontPath, 'Front')),
                          Expanded(child: _thumb(e.sidePath, 'Side')),
                          Expanded(child: _thumb(e.backPath, 'Back')),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _thumb(String path, String label) {
    final file = File(path);
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (file.existsSync())
            Image.file(file, fit: BoxFit.cover)
          else
            Container(color: Theme.of(context).colorScheme.surfaceVariant),
          Positioned(
            left: 8,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(label, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
