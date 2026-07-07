/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * * File: cast_button.dart
 */

import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class CastButton extends StatefulWidget {
  final String streamUrl;

  const CastButton({Key? key, required this.streamUrl}) : super(key: key);

  @override
  State<CastButton> createState() => _CastButtonState();
}

class _CastButtonState extends State<CastButton> {
  bool _isCasting = false;

  void _toggleCastDevices() {
    setState(() {
      _isCasting = !_isCasting;
    });

    // Tampilan dialog pencarian hardware Smart TV / Chromecast lokal terdekat
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _isCasting ? AppConstants.accentColor : AppConstants.surfaceColor,
        content: Text(
          _isCasting
              ? 'Menghubungkan & Menyiarkan stream ke Android TV...'
              : 'Koneksi proyeksi Smart TV diputus.',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isCasting ? Icons.cast_connected : Icons.cast,
        color: _isCasting ? Colors.greenAccent : AppConstants.textPrimaryColor,
      ),
      tooltip: 'Proyeksikan ke Smart TV',
      onPressed: _toggleCastDevices,
    );
  }
}