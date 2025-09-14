import 'dart:io';

import 'package:body_track/services/progress_photos_repository.dart' as local_repo; // avoid name clash
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ProgressPhotosForm extends StatefulWidget {
  const ProgressPhotosForm({super.key});

  @override
  State<ProgressPhotosForm> createState() => _ProgressPhotosFormState();
}

class _ProgressPhotosFormState extends State<ProgressPhotosForm> {
  final _picker = ImagePicker();
  File? _front;
  File? _side;
  File? _back;
  bool _saving = false;

  Future<File?> _pick(ImageSource source) async {
    final xfile = await _picker.pickImage(source: source, maxWidth: 2000, maxHeight: 2000, imageQuality: 70);
    if (xfile == null) return null;

    // copy to app documents directory to ensure persistence
    final dir = await getApplicationDocumentsDirectory();
    final fileName = xfile.name;
    final dest = File('${dir.path}/$fileName');
    return File(xfile.path).copy(dest.path);
  }

  Future<void> _chooseFor(String which) async {
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
                  if (!mounted) return;
                  setState(() {
                    if (which == 'front') _front = file;
                    if (which == 'side') _side = file;
                    if (which == 'back') _back = file;
                  });
                } on PlatformException catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'Camera not available or permission denied')),
                  );
                } catch (e) {
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
                  if (!mounted) return;
                  setState(() {
                    if (which == 'front') _front = file;
                    if (which == 'side') _side = file;
                    if (which == 'back') _back = file;
                  });
                } on PlatformException catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'Photo library not available or permission denied')),
                  );
                } catch (e) {
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

  Future<String> _uploadToStorage(String uid, String entryId, File file, String name) async {
    final ref = FirebaseStorage.instance.ref().child('users/$uid/progress_photos/$entryId/$name.jpg');
    final uploadTask = await ref.putFile(file, SettableMetadata(contentType: 'image/jpeg'));
    if (uploadTask.state != TaskState.success) {
      throw Exception('Failed to upload $name');
    }
    return await ref.getDownloadURL();
  }

  Future<void> _submit() async {
    if (_front == null || _side == null || _back == null) return;
    setState(() => _saving = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You must be signed in.')));
        return;
      }

      final id = const Uuid().v4();

      // Upload images to Firebase Storage
      final frontUrl = await _uploadToStorage(user.uid, id, _front!, 'front');
      final sideUrl = await _uploadToStorage(user.uid, id, _side!, 'side');
      final backUrl = await _uploadToStorage(user.uid, id, _back!, 'back');

      // Save document in Firestore
      final now = DateTime.now();
      await FirebaseFirestore.instance.collection('progressPhotos').doc(id).set({
        'uid': user.uid,
        'date': now,
        'frontUrl': frontUrl,
        'sideUrl': sideUrl,
        'backUrl': backUrl,
        'storagePaths': {
          'front': 'users/${user.uid}/progress_photos/$id/front.jpg',
          'side': 'users/${user.uid}/progress_photos/$id/side.jpg',
          'back': 'users/${user.uid}/progress_photos/$id/back.jpg',
        },
      });

      // Also persist locally so existing list works offline
      final repo = local_repo.ProgressPhotosRepository();
      final entry = local_repo.ProgressPhotoEntry(
        id: id,
        date: now,
        frontPath: _front!.path,
        sidePath: _side!.path,
        backPath: _back!.path,
      );
      await repo.addEntry(entry);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved')));
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: ${e.message ?? e.code}')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _slot(String label, File? file, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).dividerColor),
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
            child: file == null
                ? const Center(child: Text('Tap to add photo'))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(file, fit: BoxFit.cover, width: double.infinity),
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ready = _front != null && _side != null && _back != null;
    return AbsorbPointer(
      absorbing: _saving,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _slot('Front', _front, () => _chooseFor('front')),
              const SizedBox(height: 16),
              _slot('Side', _side, () => _chooseFor('side')),
              const SizedBox(height: 16),
              _slot('Back', _back, () => _chooseFor('back')),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: ready ? _submit : null,
                child: _saving ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
