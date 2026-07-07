/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * 
 * File: camera_model.dart
 */

class CameraModel {
  final String id;
  final String name;
  final String streamUrl;
  final int batteryPercentage; // [ 38] Status Baterai Perangkat CCTV
  final bool isOnline;
  final bool isNightMode;      // [ 11] Status Mode Malam Kamera

  CameraModel({
    required this.id,
    required this.name,
    required this.streamUrl,
    required this.batteryPercentage,
    required this.isOnline,
    required this.isNightMode,
  });

  /// Menyalin objek dengan beberapa perubahan nilai secara aman (Immutability Pattern)
  CameraModel copyWith({
    String? id,
    String? name,
    String? streamUrl,
    int? batteryPercentage,
    bool? isOnline,
    bool? isNightMode,
  }) {
    return CameraModel(
      id: id ?? this.id,
      name: name ?? this.name,
      streamUrl: streamUrl ?? this.streamUrl,
      batteryPercentage: batteryPercentage ?? this.batteryPercentage,
      isOnline: isOnline ?? this.isOnline,
      isNightMode: isNightMode ?? this.isNightMode,
    );
  }

  /// Konversi dari Map/JSON (Berguna untuk mengambil data dari database lokal)
  factory CameraModel.fromMap(Map<String, dynamic> map) {
    return CameraModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      streamUrl: map['streamUrl'] ?? '',
      batteryPercentage: map['batteryPercentage'] ?? 100,
      isOnline: map['isOnline'] ?? false,
      isNightMode: map['isNightMode'] ?? false,
    );
  }

  /// Konversi ke Map/JSON (Berguna untuk backup konfigurasi atau transfer data ke Web Mirror)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'streamUrl': streamUrl,
      'batteryPercentage': batteryPercentage,
      'isOnline': isOnline,
      'isNightMode': isNightMode,
    };
  }
}
