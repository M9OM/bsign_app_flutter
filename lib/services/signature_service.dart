import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SignatureService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final _uuid = const Uuid();

  /// Converts a UI Image to PNG bytes.
  Future<Uint8List> convertImageToBytes(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception('Could not convert image to byte data.');
    }
    return byteData.buffer.asUint8List();
  }

  /// Saves PNG bytes to a temporary file and returns the File.
  Future<File> saveToTempFile(Uint8List bytes, String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    return file;
  }

  /// Uploads the file to Supabase Storage.
  Future<void> uploadToStorage(File file, String path) async {
    await _supabase.storage.from('signatures').upload(
      path,
      file,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );
  }

  /// Gets the public URL of the uploaded file.
  String getPublicUrl(String path) {
    return _supabase.storage.from('signatures').getPublicUrl(path);
  }



}
