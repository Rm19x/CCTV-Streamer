/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * 
 * File: camera_provider.dart
 */

import 'package:flutter/material.dart';
import '../models/camera_model.dart';

class CameraProvider with ChangeNotifier {
  //  database internal lokal untuk daftar kamera CCTV yang aktif di rumah
  final List<CameraModel> _cameras = [
    CameraModel(
      id: 'cam_01',
      name: 'Teras Depan',
      streamUrl: 'rtsp://192.168.1.100:554/stream1',
      batteryPercentage: 85,
      isOnline: true,
      isNightMode: false,
    ),
    CameraModel(
      id: 'cam_02',
      name: 'Garasi Samping',
      streamUrl: 'rtsp://192.168.1.101:554/stream1',
      batteryPercentage: 14, // Memicu tanda peringatan baterai kritis di UI [ 38]
      isOnline: true,
      isNightMode: true, // Sedang dalam mode inframerah [ 11]
    ),
    CameraModel(
      id: 'cam_03',
      name: 'Gudang Belakang',
      streamUrl: 'http://192.168.1.102:8080/mjpeg',
      batteryPercentage: 100, // Status penuh (menggunakan kabel adaptor langsung)
      isOnline: true,
      isNightMode: false,
    ),
  ];

  bool _isWebMirrorRunning = false;
  String _webMirrorUrl = '';

  // Getters
  List<CameraModel> get cameras => _cameras;
  bool get isWebMirrorRunning => _isWebMirrorRunning;
  String get webMirrorUrl => _webMirrorUrl;

  /// [ 11] Mengaktifkan / Mematikan Mode Malam Kamera Secara Jarak Jauh (Remote Toggle)
  void toggleNightMode(String cameraId) {
    final index = _cameras.indexWhere((cam) => cam.id == cameraId);
    if (index != -1) {
      final currentStatus = _cameras[index].isNightMode;
      _cameras[index] = _cameras[index].copyWith(isNightMode: !currentStatus);
      
      // Memicu rendering ulang pada UI Widget yang sedang memantau kamera ini
      notifyListeners();
    }
  }

  /// [ 38] Sinkronisasi Status Sisa Daya Baterai Hardware Kamera secara Berkala
  void updateBatteryStatus(String cameraId, int newPercentage) {
    final index = _cameras.indexWhere((cam) => cam.id == cameraId);
    if (index != -1) {
      _cameras[index] = _cameras[index].copyWith(batteryPercentage: newPercentage.clamp(0, 100));
      notifyListeners();
    }
  }

  /// [ 49] Mengaktifkan status jaringan untuk Mirroring ke browser laptop
  void startWebMirrorServer(int port) {
    _isWebMirrorRunning = true;
    //  penyiaran port server HTTP lokal dari IP perangkat smartphone kamu
    _webMirrorUrl = 'http://192.168.1.5:$port';
    notifyListeners();
  }

  /// [ 49] Menghentikan penyiaran Web Dashboard Mirror
  void stopWebMirrorServer() {
    _isWebMirrorRunning = false;
    _webMirrorUrl = '';
    notifyListeners();
  }

  /// Menambahkan unit kamera CCTV baru ke dalam daftar pantauan grid aplikasi
  void addCamera(CameraModel newCamera) {
    _cameras.add(newCamera);
    notifyListeners();
  }
}
