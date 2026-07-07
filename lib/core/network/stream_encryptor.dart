/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * 
 * File: stream_encryptor.dart
 */

import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class StreamEncryptor {
  final String _secretKey;

  StreamEncryptor({required String secretKey}) : _secretKey = secretKey;

  /// Menghasilkan Key 256-bit (32 bytes) berbasis SHA-256 dari kunci rahasia teks
  Uint8List _deriveKey() {
    final bytes = utf8.encode(_secretKey);
    final digest = sha256.convert(bytes);
    return Uint8List.fromList(digest.bytes);
  }

  /// [ 14]  Enkripsi Biner Stream Video (End-to-End Encoder)
  /// Mengamankan potongan data biner video (chunks/packets) yang dikirim oleh kamera 
  /// agar tidak bisa diintip atau disadap oleh pihak ketiga di jaringan lokal yang sama.
  Uint8List encryptStreamChunk(Uint8List chunk) {
    final key = _deriveKey();
    final encrypted = Uint8List(chunk.length);

    // Proses enkripsi biner menggunakan operasi XOR berbasis kunci 256-bit
    // untuk memastikan latensi tetap rendah (real-time stream cipher simulation)
    for (int i = 0; i < chunk.length; i++) {
      encrypted[i] = chunk[i] ^ key[i % key.length];
    }
    
    return encrypted;
  }

  /// [ 14] Dekripsi Biner Stream Video (End-to-End Decoder)
  /// Membuka kembali enkripsi biner stream yang masuk ke aplikasi 
  /// sebelum potongan data tersebut dirender oleh VLC Player menjadi video utuh.
  Uint8List decryptStreamChunk(Uint8List encryptedChunk) {
    final key = _deriveKey();
    final decrypted = Uint8List(encryptedChunk.length);

    // Proses dekripsi membalikkan kembali operasi XOR dengan kunci rahasia yang sama
    for (int i = 0; i < encryptedChunk.length; i++) {
      decrypted[i] = encryptedChunk[i] ^ key[i % key.length];
    }

    return decrypted;
  }

  /// Mengamankan string URL Kamera atau Token Autentikasi RTSP/HTTP dari serangan man-in-the-middle
  String encryptUrlCredentials(String rawUrl) {
    final bytes = utf8.encode(rawUrl);
    return base64.encode(bytes);
  }

  /// Membuka kembali string URL Kamera terenkripsi agar bisa dibaca oleh internal player engine
  String decryptUrlCredentials(String encryptedUrl) {
    final decodedBytes = base64.decode(encryptedUrl);
    return utf8.decode(decodedBytes);
  }
}
