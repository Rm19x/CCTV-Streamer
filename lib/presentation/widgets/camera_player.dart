/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * * File: camera_player.dart
 */

import 'package:flutter/material.dart';
import 'dart:async';
import '../../core/constants/app_constants.dart';

class CameraPlayer extends StatefulWidget {
  final String streamUrl;
  final String cameraName;

  const CameraPlayer({
    Key? key,
    required this.streamUrl,
    required this.cameraName,
  }) : super(key: key);

  @override
  State<CameraPlayer> createState() => _CameraPlayerState();
}

class _CameraPlayerState extends State<CameraPlayer> {
  late Stream<DateTime> _timeStream;

  @override
  void initState() {
    super.initState();
    // [ 30] Stream untuk memperbarui jam watermark setiap 1 detik secara real-time
    _timeStream = Stream<DateTime>.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now(),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container dasar  engine player video (VLC / MJPEG)
        Positioned.fill(
          child: Container(
            color: Colors.black,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppConstants.accentColor),
              ),
            ),
          ),
        ),
        
        // [ 30] Teks Overlay Watermark di Sisi Atas/Pojok Video Stream
        Positioned(
          top: 12,
          right: 12,
          child: StreamBuilder<DateTime>(
            stream: _timeStream,
            builder: (context, snapshot) {
              final timeString = snapshot.hasData 
                  ? _formatDateTime(snapshot.data!) 
                  : 'Memuat Waktu...';
              
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  '${widget.cameraName} | $timeString',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
