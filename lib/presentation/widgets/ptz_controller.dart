/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * * File: ptz_controller.dart
 */

import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class PtzController extends StatelessWidget {
  final String cameraId;
  final Function(String direction) onDirectionPressed;

  const PtzController({
    Key? key,
    required this.cameraId,
    required this.onDirectionPressed,
  }) : super(key: key);

  Widget _buildArrowButton(IconData icon, String direction) {
    return GestureDetector(
      onTap: () => onDirectionPressed(direction),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: AppConstants.surfaceColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppConstants.textPrimaryColor, size: 28),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: AppConstants.primaryColor.withOpacity(0.4),
        shape: BoxShape.circle,
        border: Border.all(color: AppConstants.textSecondaryColor.withOpacity(0.3)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Tombol Atas
          Positioned(top: 4, child: _buildArrowButton(Icons.arrow_drop_up, 'UP')),
          // Tombol Bawah
          Positioned(bottom: 4, child: _buildArrowButton(Icons.arrow_drop_down, 'DOWN')),
          // Tombol Kiri
          Positioned(left: 4, child: _buildArrowButton(Icons.arrow_left, 'LEFT')),
          // Tombol Kanan
          Positioned(right: 4, child: _buildArrowButton(Icons.arrow_right, 'RIGHT')),
          
          // Bagian tengah sebagai ornamen pusat joystick pad
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: AppConstants.accentColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.gamepad, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}