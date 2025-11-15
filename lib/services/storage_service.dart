import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  Future<String> uploadReceipt(String userId, File file) async {
    try {
      final fileName = '${_uuid.v4()}.jpg';
      final ref = _storage.ref().child('receipts/$userId/$fileName');
      
      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      // If storage is not configured, return empty string
      print('Storage upload failed: $e');
      return '';
    }
  }

  Future<void> deleteReceipt(String url) async {
    try {
      if (url.isEmpty) return;
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      print('Storage delete failed: $e');
      // Ignore storage errors
    }
  }
}
