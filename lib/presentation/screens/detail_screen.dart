/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * * File: detail_screen.dart
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../data/providers/camera_provider.dart';

class DetailScreen extends StatefulWidget {
  final String cameraId;

  const DetailScreen({Key? key, required this.cameraId}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TransformationController _transformationController = TransformationController();
  bool _isIntercomActive = false;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  /// [ 2] Mengembalikan ukuran zoom ke semula saat double-tap terdeteksi
  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      _transformationController.value = Matrix4.identity()..scale(2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cameraProvider = Provider.of<CameraProvider>(context);
    // Mencari kamera yang sesuai berdasarkan ID
    final camera = cameraProvider.cameras.firstWhere((cam) => cam.id == widget.cameraId);

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        iconTheme: const IconThemeData(color: AppConstants.textPrimaryColor),
        title: Text(
          camera.name,
          style: const TextStyle(color: AppConstants.textPrimaryColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          // [ 11] Night Mode Toggle Button
          IconButton(
            icon: Icon(
              camera.isNightMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: camera.isNightMode ? Colors.purpleAccent : Colors.orange,
            ),
            tooltip: 'Mode Malam',
            onPressed: () {
              cameraProvider.toggleNightMode(camera.id);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // --- PEMUTAR VIDEO STREAM UTAMA ---
          GestureDetector(
            onDoubleTap: _handleDoubleTap,
            child: AspectRatio(
              aspectRatio: AppConstants.defaultGridAspectRatio,
              child: Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    // [ 2] InteractiveViewer menangani perbesaran (Zooming & Panning)
                    Positioned.fill(
                      child: InteractiveViewer(
                        transformationController: _transformationController,
                        maxScale: 4.0,
                        child: const Center(
                          child: Text(
                            '[  Live VLC Player Engine ]',
                            style: TextStyle(color: AppConstants.textSecondaryColor),
                          ),
                        ),
                      ),
                    ),
                    // Indikator Status Tambahan di Atas Layar Player
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: camera.isNightMode ? Colors.greenAccent : AppConstants.accentColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            camera.isNightMode ? 'MODE INFRARED AKTIF' : 'LIVE STREAMING',
                            style: const TextStyle(color: AppConstants.textPrimaryColor, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),

          // --- AREA KONTROL HARDWARE & UTENSIL ---
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: AppConstants.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // [ 5] UI Joystick Kontrol PTZ (Arah Kamera)
                  Column(
                    children: [
                      const Text(
                        'KONTROL DIRECTION (PTZ)',
                        style: TextStyle(color: AppConstants.textSecondaryColor, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      IconButton(icon: const Icon(Icons.arrow_drop_up, size: 36, color: Colors.white), onPressed: () {}),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(icon: const Icon(Icons.arrow_left, size: 36, color: Colors.white), onPressed: () {}),
                          const SizedBox(width: 40),
                          IconButton(icon: const Icon(Icons.arrow_right, size: 36, color: Colors.white), onPressed: () {}),
                        ],
                      ),
                      IconButton(icon: const Icon(Icons.arrow_drop_down, size: 36, color: Colors.white), onPressed: () {}),
                    ],
                  ),
                  
                  // [ 5] Tombol Aktivasi Interkom Suara Dua Arah
                  GestureDetector(
                    onLongPressStart: (_) {
                      setState(() => _isIntercomActive = true);
                    },
                    onLongPressEnd: (_) {
                      setState(() => _isIntercomActive = false);
                    },
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: _isIntercomActive ? AppConstants.alertColor : AppConstants.accentColor,
                      child: Icon(
                        _isIntercomActive ? Icons.mic : Icons.mic_none,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    _isIntercomActive ? 'Mendengarkan & Menyiarkan Audio...' : 'Tahan tombol mikrofon untuk berbicara (Interkom)',
                    style: TextStyle(
                      color: _isIntercomActive ? AppConstants.alertColor : AppConstants.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
