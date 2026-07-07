/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * * File: home_screen.dart
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../data/providers/camera_provider.dart';
import 'detail_screen.dart';
import 'web_mirror_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : constructor(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: const Text(
          AppConstants.appName,
          style: TextStyle(color: AppConstants.textPrimaryColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: AppConstants.accentColor),
            tooltip: 'Web Mirror Dashboard',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WebMirrorScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<CameraProvider>(
        builder: (context, cameraProvider, child) {
          final cameras = cameraProvider.cameras;

          return OrientationBuilder(
            builder: (context, orientation) {
              // Mengatur jumlah grid berdasarkan orientasi layar (HP tegak atau miring)
              final crossAxisCount = orientation == Orientation.portrait 
                  ? AppConstants.defaultGridCrossAxisCount 
                  : 3;

              return GridView.builder(
                padding: const EdgeInsets.all(12.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: AppConstants.defaultGridAspectRatio,
                ),
                itemCount: cameras.length,
                itemBuilder: (context, index) {
                  final camera = cameras[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(cameraId: camera.id),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppConstants.surfaceColor,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: camera.isOnline ? AppConstants.accentColor.withOpacity(0.5) : Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // area  video decoder placeholder
                          Positioned.fill(
                            child: Container(
                              color: Colors.blackDE,
                              child: Center(
                                child: Icon(
                                  camera.isOnline ? Icons.videocam : Icons.videocam_off,
                                  color: camera.isOnline ? AppConstants.accentColor : Colors.grey,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          // Overlay Watermark Nama Kamera & Indikator Baterai [ 38]
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                              color: Colors.black.withOpacity(0.6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      camera.name,
                                      style: const TextStyle(
                                        color: AppConstants.textPrimaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        camera.batteryPercentage <= 20 
                                            ? Icons.battery_alert 
                                            : Icons.battery_charging_full,
                                        size: 14,
                                        color: camera.batteryPercentage <= 20 
                                            ? AppConstants.alertColor 
                                            : Colors.green,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${camera.batteryPercentage}%',
                                        style: TextStyle(
                                          color: camera.batteryPercentage <= 20 
                                              ? AppConstants.alertColor 
                                              : AppConstants.textPrimaryColor,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
