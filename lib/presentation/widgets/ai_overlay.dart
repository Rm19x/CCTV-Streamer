/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * * File: ai_overlay.dart
 */

import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/ai_handler.dart';

class AiOverlay extends StatelessWidget {
  final List<RecognitionResult> detections;
  final String? recognizedFace;
  final double previewWidth;
  final double previewHeight;

  const AiOverlay({
    Key? key,
    required this.detections,
    this.recognizedFace,
    required this.previewWidth,
    required this.previewHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          // [ 16] Menggambar Kotak Pembatas untuk Setiap Objek Terdeteksi
          ...detections.map((res) {
            return Positioned(
              left: res.xMin * previewWidth,
              top: res.yMin * previewHeight,
              width: (res.xMax - res.xMin) * previewWidth,
              height: (res.yMax - res.yMin) * previewHeight,
              child: Container(
                decoration: Border.all(
                  color: AppConstants.accentColor,
                  width: 2.0,
                ),
                child: Container(
                  color: AppConstants.accentColor.withOpacity(0.15),
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    '${res.title} ${(res.confidence * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(
                      color: AppConstants.accentColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),

          // [ 18] Menggambar Label Khusus jika Wajah Dikenali di Area Tengah Kamera
          if (recognizedFace != null)
            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: recognizedFace!.contains('Unknown') 
                      ? AppConstants.alertColor 
                      : Colors.green,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  children: [
                    Icon(
                      recognizedFace!.contains('Unknown') ? Icons.warning : Icons.face,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      recognizedFace!.contains('Unknown') 
                          ? AppConstants.txtUnknownFace 
                          : '${AppConstants.txtFaceRecognized} $recognizedFace',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
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