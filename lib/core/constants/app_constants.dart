/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * * File: app_constants.dart
 */

import 'package:flutter/material.dart';

class AppConstants {
  // --- Info Aplikasi & Copyright ---
  static const String appName = 'CCTV Streamer RM19';
  static const String appVersion = '1.0.0';
  static const String copyrightText = 'Copyright (c) 2026 Mr.Rm19';
  static const String githubRepo = 'https://github.com/Rm19x';

  // --- Konfigurasi  & Sistem ---
  
  // [ 1] Grid View Configuration
  static const int defaultGridCrossAxisCount = 2;
  static const double defaultGridAspectRatio = 16 / 9;

  // [ 14] Security & Encryption Configuration
  static const String encryptionAlgorithm = 'AES/CBC/PKCS7Padding';
  static const int encryptionKeyLength = 32; // 256-bit key

  // [ 16 & 18] AI Model Configuration
  static const String objectDetectionModelPath = 'assets/models/ssd_mobilenet.tflite';
  static const String faceRecognitionModelPath = 'assets/models/facenet.tflite';
  static const double aiConfidenceThreshold = 0.60; // Akurasi minimal AI (60%)

  // [ 23] Audio Analytics Configuration
  static const double decibelThresholdAlarm = 85.0; // Batas suara keras dalam desibel (dB)

  // [ 49] Web Dashboard Mirror Configuration
  static const int defaultWebMirrorPort = 8080;
  static const String webMirrorPath = '/stream-mirror';

  // --- Konfigurasi UI & Tema Warna (Nuansa Cyber/Dark Tech) ---
  static const Color primaryColor = Color(0xFF1E1E2E);    // Slate Grey / Dark Base
  static const Color accentColor = Color(0xFF00ADB5);     // Cyan untuk status streaming/aktif
  static const Color backgroundColor = Color(0xFF11111B); // Hitam Pekat untuk latar monitor
  static const Color surfaceColor = Color(0xFF252538);    // Background card/komponen kecil
  static const Color textPrimaryColor = Color(0xFFFFFFFF);
  static const Color textSecondaryColor = Color(0xFFA0A0B8);
  static const Color alertColor = Color(0xFFFF5555);      // Merah untuk alarm pergerakan & baterai lemah

  // --- Konten Teks Global / Lokalisasi (Bahasa Indonesia) ---
  static const String txtLoadingStream = 'Menghubungkan ke dekoder CCTV...';
  static const String txtStreamError = 'Koneksi terputus. Mencoba menghubungkan kembali...';
  static const String txtMotionDetected = 'PERINGATAN: Pergerakan terdeteksi pada kamera!';
  static const String txtFaceRecognized = 'Wajah teridentifikasi:';
  static const String txtUnknownFace = 'Wajah asing terdeteksi!';
  static const String txtLoudNoiseDetected = 'Peringatan: Suara keras/tangisan terdeteksi!';
  static const String txtBatteryLow = 'Baterai perangkat CCTV sangat lemah!';
  static const String txtWebMirrorActive = 'Web Mirror Aktif. Akses melalui browser laptop di:';
}
