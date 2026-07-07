/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * * File: main.dart
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'core/utils/ai_handler.dart';
import 'data/providers/camera_provider.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  // Memastikan binding Flutter engine telah siap sebelum melakukan inisialisasi async
  WidgetsFlutterBinding.ensureInitialized();

  // [ 16 & 18] Inisialisasi dan pemuatan model kecerdasan buatan (AI Engine) ke memori RAM
  final aiHandler = AiHandler();
  await aiHandler.initAiModels(
    objectModelPath: AppConstants.objectDetectionModelPath,
    faceModelPath: AppConstants.faceRecognitionModelPath,
  );

  runApp(
    // Menyuntikkan CameraProvider di tingkat paling atas (Root) agar bisa diakses di semua Screen & Widget
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CameraProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      
      // Mengonfigurasi tema global aplikasi berbasis Cyber Dark Tech sesuai AppConstants
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        primaryColor: AppConstants.primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.accentColor,
          background: AppConstants.backgroundColor,
          surface: AppConstants.surfaceColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppConstants.primaryColor,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      
      // Mengarahkan tampilan pertama langsung ke halaman Multi-Camera Grid View
      home: const HomeScreen(),
    );
  }
}
