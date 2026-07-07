# CCTV Streamer 

[![Flutter](https://img.shields.io/badge/Platform-Flutter%20%7C%20Dart-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Developer](https://img.shields.io/badge/Developer-Mr.Rm19-00ADB5?style=flat&logo=github)](https://github.com/Rm19x)

**CCTV Streamer** adalah aplikasi pemantauan kamera pengawas pintar (*Smart Surveillance*) berbasis *cross-platform* yang dibangun menggunakan Flutter dan Dart. Aplikasi ini dirancang dengan fokus pada performa *streaming* latensi rendah, keamanan enkripsi *end-to-end*, serta integrasi kecerdasan buatan (*AI*) untuk analitik video dan audio secara langsung di perangkat (*on-device processing*).

---

##  Fitur Utama

Aplikasi ini dilengkapi dengan 12 fitur unggulan yang mencakup aspek pemantauan esensial hingga fungsionalitas pintar:

1. **Multi-Camera Grid View:** Menampilkan banyak kamera sekaligus dalam tata letak *grid* reaktif (2x2 atau 3x3) yang menyesuaikan orientasi layar.
2. **Double-Tap to Zoom:** Memungkinkan pengguna melakukan *digital zoom* dan *panning* instan secara interaktif pada video yang sedang berjalan.
3. **Two-Way Audio (Interkom) & PTZ:** Kontrol pergerakan lensa kamera (*Pan-Tilt-Zoom*) dari jarak jauh beriringan dengan fitur komunikasi suara dua arah.
4. **Night Mode Toggle:** Mengubah mode kamera ke sensor *Infrared / Night Vision* secara manual maupun otomatis via API.
5. **Enkripsi Stream End-to-End:** Mengamankan potongan biner data video (*raw stream chunks*) menggunakan algoritma berbasis kunci 256-bit agar aman dari penyadapan jaringan.
6. **Deteksi Objek Berbasis AI:** Memanfaatkan model ringan TensorFlow Lite untuk mendeteksi dan memberi kotak pembatas (*bounding box*) pada objek manusia atau hewan.
7. **Face Recognition:** Mengenali wajah yang tertangkap kamera dan mencocokkannya dengan database pemilik, serta memberikan alarm jika wajah asing terdeteksi.
8. **Deteksi Suara Keras (Audio Analytics):** Menganalisis frekuensi gelombang amplitudo audio (skala Desibel) untuk mendeteksi suara tangisan, teriakan, atau dentuman keras.
9. **Watermark Waktu & Nama:** Menimpa video dengan teks penanda nama lokasi kamera dan *timestamp* yang sinkron per detik secara *real-time*.
10. **Smart TV / Chromecast Mirroring:** Memproyeksikan tampilan *live stream* monitor langsung dari smartphone ke layar Android TV atau Smart TV terdekat.
11. **Status Baterai Kamera:** Menampilkan indikator persentase daya baterai *hardware* kamera pengawas secara *real-time* lengkap dengan sinyal peringatan kritis.
12. **Web Dashboard Mirror:** Menjalankan HTTP server lokal terintegrasi dari smartphone, memungkinkan perangkat PC/Laptop dalam jaringan Wi-Fi yang sama untuk mengakses monitor via web browser.

---

Copyright  2026 Mr.Rm19
All rights reserved.
