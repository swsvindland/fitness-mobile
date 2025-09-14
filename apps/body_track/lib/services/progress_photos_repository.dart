import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ProgressPhotoEntry {
  final String id; // unique id
  final DateTime date;
  final String frontPath;
  final String sidePath;
  final String backPath;

  ProgressPhotoEntry({
    required this.id,
    required this.date,
    required this.frontPath,
    required this.sidePath,
    required this.backPath,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date.toIso8601String(),
        'frontPath': frontPath,
        'sidePath': sidePath,
        'backPath': backPath,
      };

  factory ProgressPhotoEntry.fromMap(Map<String, dynamic> map) => ProgressPhotoEntry(
        id: map['id'] as String,
        date: DateTime.parse(map['date'] as String),
        frontPath: map['frontPath'] as String,
        sidePath: map['sidePath'] as String,
        backPath: map['backPath'] as String,
      );
}

class ProgressPhotosRepository {
  static const _fileName = 'progress_photos.json';

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$_fileName');
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(<Map<String, dynamic>>[]));
    }
    return file;
  }

  Future<List<ProgressPhotoEntry>> loadEntries() async {
    try {
      final file = await _getFile();
      final content = await file.readAsString();
      final List<dynamic> list = jsonDecode(content);
      return list
          .map((e) => ProgressPhotoEntry.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));
    } catch (_) {
      return [];
    }
  }

  Future<void> saveEntries(List<ProgressPhotoEntry> entries) async {
    final file = await _getFile();
    final list = entries.map((e) => e.toMap()).toList();
    await file.writeAsString(jsonEncode(list));
  }

  Future<void> addEntry(ProgressPhotoEntry entry) async {
    final entries = await loadEntries();
    entries.add(entry);
    await saveEntries(entries);
  }

  Future<void> deleteEntry(String id) async {
    final entries = await loadEntries();
    entries.removeWhere((e) => e.id == id);
    await saveEntries(entries);
  }
}
