/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * * File: web_mirror_screen.dart
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../data/providers/camera_provider.dart';

class WebMirrorScreen extends StatelessWidget {
  const WebMirrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        iconTheme: const IconThemeData(color: AppConstants.textPrimaryColor),
        title: const Text(
          'Web Mirror Dashboard Server',
          style: TextStyle(color: AppConstants.textPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<CameraProvider>(
        builder: (context, cameraProvider, child) {
          final isRunning = cameraProvider.isWebMirrorRunning;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.dns,
                  size: 80,
                  color: isRunning ? AppConstants.accentColor : AppConstants.textSecondaryColor,
                ),
                const SizedBox(height: 24),
                Text(
                  isRunning ? 'STATUS: SERVER AKTIF' : 'STATUS: SERVER BERHENTI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isRunning ? AppConstants.accentColor : AppConstants.alertColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppConstants.surfaceColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        isRunning 
                            ? AppConstants.txtWebMirrorActive 
                            : 'Aktifkan server lokal untuk memantau grid kamera langsung dari browser laptop atau PC Anda dalam satu jaringan Wi-Fi.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppConstants.textPrimaryColor, fontSize: 13),
                      ),
                      if (isRunning) ...[
                        const SizedBox(height: 12),
                        SelectableText(
                          '${cameraProvider.webMirrorUrl}${AppConstants.webMirrorPath}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRunning ? AppConstants.alertColor : AppConstants.accentColor,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onPressed: () {
                    if (isRunning) {
                      cameraProvider.stopWebMirrorServer();
                    } else {
                      cameraProvider.startWebMirrorServer(AppConstants.defaultWebMirrorPort);
                    }
                  },
                  child: Text(
                    isRunning ? 'MATIKAN WEB MIRROR' : 'AKTIFKAN WEB MIRROR',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
