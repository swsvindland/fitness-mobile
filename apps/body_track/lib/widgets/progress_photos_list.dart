import 'dart:io';

import 'package:body_track/services/progress_photos_repository.dart' as local_repo;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ProgressPhotosList extends StatefulWidget {
  const ProgressPhotosList({super.key});

  @override
  State<ProgressPhotosList> createState() => _ProgressPhotosListState();
}

class _ProgressPhotosListState extends State<ProgressPhotosList> {
  final _repo = local_repo.ProgressPhotosRepository();
  final _picker = ImagePicker();
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

  Future<File?> _pick(ImageSource source) async {
    final xfile = await _picker.pickImage(source: source, maxWidth: 2000, maxHeight: 2000, imageQuality: 70);
    if (xfile == null) return null;
    final dir = await getApplicationDocumentsDirectory();
    final fileName = xfile.name;
    final dest = File('${dir.path}/$fileName');
    return File(xfile.path).copy(dest.path);
  }

  Future<void> _chooseForUpdate(local_repo.ProgressPhotoEntry entry, String which) async {
    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Take photo'),
              onTap: () async {
                Navigator.of(ctx).pop();
                try {
                  final file = await _pick(ImageSource.camera);
                  if (file == null) return;
                  await _updateEntryWithFile(entry, which, file);
                } on PlatformException catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'Camera not available or permission denied')),
                  );
                } catch (_) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unable to open camera.')),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from library'),
              onTap: () async {
                Navigator.of(ctx).pop();
                try {
                  final file = await _pick(ImageSource.gallery);
                  if (file == null) return;
                  await _updateEntryWithFile(entry, which, file);
                } on PlatformException catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'Photo library not available or permission denied')),
                  );
                } catch (_) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unable to open photo library.')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateEntryWithFile(local_repo.ProgressPhotoEntry entry, String which, File file) async {
    try {
      if (which == 'front') {
        await _repo.updateEntry(entry.id, frontPath: file.path);
      } else if (which == 'side') {
        await _repo.updateEntry(entry.id, sidePath: file.path);
      } else if (which == 'back') {
        await _repo.updateEntry(entry.id, backPath: file.path);
      }
      await _reload();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update photo.')),
      );
    }
  }

  Future<void> _showEditOptions(local_repo.ProgressPhotoEntry entry) async {
    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Update front photo'),
              onTap: () {
                Navigator.of(ctx).pop();
                _chooseForUpdate(entry, 'front');
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Update side photo'),
              onTap: () {
                Navigator.of(ctx).pop();
                _chooseForUpdate(entry, 'side');
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Update back photo'),
              onTap: () {
                Navigator.of(ctx).pop();
                _chooseForUpdate(entry, 'back');
              },
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete entry'),
              textColor: Colors.red,
              iconColor: Colors.red,
              onTap: () async {
                Navigator.of(ctx).pop();
                final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (dCtx) => AlertDialog(
                        title: const Text('Delete entry?'),
                        content: const Text('This will remove the photos from the app. This action cannot be undone.'),
                        actions: [
                          TextButton(onPressed: () => Navigator.of(dCtx).pop(false), child: const Text('Cancel')),
                          TextButton(onPressed: () => Navigator.of(dCtx).pop(true), child: const Text('Delete')),
                        ],
                      ),
                    ) ??
                    false;
                if (confirmed) {
                  await _repo.deleteEntry(entry.id);
                  if (!mounted) return;
                  _reload();
                }
              },
            ),
          ],
        ),
      ),
    );
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
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  onTap: () => _showEditOptions(e),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(DateFormat.yMMMd().format(e.date), style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Row(
                        children: [
                          Expanded(child: _thumb(e.frontPath, 'Front', () => _showPhotoViewer(e.frontPath, 'Front'))),
                          Expanded(child: _thumb(e.sidePath, 'Side', () => _showPhotoViewer(e.sidePath, 'Side'))),
                          Expanded(child: _thumb(e.backPath, 'Back', () => _showPhotoViewer(e.backPath, 'Back'))),
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

  Widget _thumb(String path, String label, VoidCallback onTap) {
    final file = File(path);
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: GestureDetector(
        onTap: onTap,
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
      ),
    );
  }

  Future<void> _showPhotoViewer(String path, String label) async {
    final file = File(path);
    await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Positioned.fill(
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4.0,
                  child: file.existsSync()
                      ? Image.file(file, fit: BoxFit.contain)
                      : Container(
                          alignment: Alignment.center,
                          color: Colors.black,
                          child: Text('Missing $label photo', style: const TextStyle(color: Colors.white70)),
                        ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
