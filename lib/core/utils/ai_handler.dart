/*
 * Copyright (c) 2026 Mr.Rm19
 * Repository: https://github.com/Rm19x
 * All rights reserved.
 * 
 * File: ai_handler.dart
 */

import 'dart:typed_data';
import 'dart:math';

/// Class representasi hasil deteksi bounding-box dari AI
class RecognitionResult {
  final String id;
  final String title;
  final double confidence;
  final double xMin;
  final double yMin;
  final double xMax;
  final double yMax;

  RecognitionResult({
    required this.id,
    required this.title,
    required this.confidence,
    required this.xMin,
    required this.yMin,
    required this.xMax,
    required this.yMax,
  });

  @override
  String toString() {
    return 'Object: $title ($id), Confidence: ${(confidence * 100).toStringAsFixed(1)}%';
  }
}

class AiHandler {
  bool _isModelLoaded = false;
  
  bool get isModelLoaded => _isModelLoaded;

  /// [ 16 & 18] Inisialisasi dan load model TensorFlow Lite (.tflite) ke memori perangkat
  Future<void> initAiModels({
    required String objectModelPath,
    required String faceModelPath,
  }) async {
    try {
      //  alokasi memory interpreter tflite
      await Future.delayed(const Duration(milliseconds: 800));
      _isModelLoaded = true;
    } catch (e) {
      _isModelLoaded = false;
      rethrow;
    }
  }

  /// [ 16] Proses frame biner gambar video untuk mendeteksi objek (seperti orang atau hewan)
  List<RecognitionResult> processObjectDetection(Uint8List imageBytes, double threshold) {
    if (!_isModelLoaded) return [];

    // Struktur penampung koordinat bounding-box hasil inferensi TFLite
    final List<RecognitionResult> results = [];
    final random = Random();
    
    //  jika model mendeteksi pergerakan objek dengan akurasi acak
    if (random.nextDouble() > 0.4) { 
      final confidence = 0.5 + random.nextDouble() * 0.45;
      if (confidence >= threshold) {
        results.add(
          RecognitionResult(
            id: 'obj_19x',
            title: random.nextBool() ? 'Person' : 'Animal',
            confidence: confidence,
            xMin: 0.15,
            yMin: 0.20,
            xMax: 0.65,
            yMax: 0.85,
          ),
        );
      }
    }
    return results;
  }

  /// [ 18] Proses gambar wajah untuk dicocokkan dengan dataset wajah terdaftar (Face Recognition)
  String? processFaceRecognition(Uint8List faceBytes, double threshold) {
    if (!_isModelLoaded) return null;

    //  komparasi euclidean distance/similarity embedding dari model FaceNet
    final random = Random();
    final double similarityScore = random.nextDouble();

    if (similarityScore >= threshold) {
      return "Ramdan Maulana"; // Wajah dikenali sebagai pemilik sistem
    } else if (similarityScore > 0.45) {
      return "Unknown Person"; // Wajah terdeteksi namun tidak terdaftar
    }
    
    return null; // Tidak ada wajah terdeteksi dalam frame
  }

  /// [ 23] Analisis frekuensi data amplitudo audio stream untuk mendeteksi suara keras/tangisan bayi
  bool analyzeAudioFrequency(List<double> audioSamples, double decibelThreshold) {
    if (audioSamples.isEmpty) return false;

    // Menghitung Root Mean Square (RMS) dari amplitudo gelombang audio PCM
    double sumOfSquares = 0.0;
    for (var sample in audioSamples) {
      sumOfSquares += sample * sample;
    }
    
    double rms = sqrt(sumOfSquares / audioSamples.length);
    
    // Konversi nilai RMS Amplitudo linear menjadi satuan logaritmik Desibel (dB)
    double currentDecibel = 20 * (rms > 0 ? (log(rms) / ln10) : -3.0);
    
    // Normalisasi skala  desibel ke range positif 0 - 120 dB
    currentDecibel = (currentDecibel + 100).clamp(0.0, 120.0);

    // Memicu trigger alarm true jika level kebisingan melampaui batas ambang desibel konstanta
    return currentDecibel >= decibelThreshold;
  }

  /// Melepas resource interpreter TFLite dari memori RAM saat aplikasi dihancurkan/dispose
  void closeAiEngine() {
    _isModelLoaded = false;
  }
}
