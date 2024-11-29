import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// layar utama untuk memindai qr code.
class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCustomSnackbar();
    });
  }

  void _showCustomSnackbar() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CustomSnackbar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code")
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
              returnImage: true,
            ),
            onDetect: (capture) {
              _handleQrDetection(capture);
            },
          ),
          Center(
            child: CustomPaint(
              size: const Size(250, 250),
              painter: SmoothRoundedPainter(),
            ),
          ),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Point the QR code into the box",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleQrDetection(BarcodeCapture capture) {
    final Uint8List? image = capture.image;

    if (image != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Image.memory(image),
        ),
      );
    }
  }
}

/// custom painter untuk fokus qr code.
class SmoothRoundedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path();
    const double cornerSize = 20;

    // sudut kiri atas
    path.moveTo(0, cornerSize);
    path.lineTo(0, 0);
    path.lineTo(cornerSize, 0);

    // sudut kanan atas
    path.moveTo(size.width - cornerSize, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, cornerSize);

    // sudut kiri bawah
    path.moveTo(0, size.height - cornerSize);
    path.lineTo(0, size.height);
    path.lineTo(cornerSize, size.height);

    // sudut kanan bawah
    path.moveTo(size.width - cornerSize, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - cornerSize);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// snackbar kustom untuk informasi tambahan.
class CustomSnackbar extends StatelessWidget {
  const CustomSnackbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Scan QR Code",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Place QR code inside the frame to scan. Please avoid shake to get results quickly.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.asset(
              'assets/images/scan-icon.png',
              width: 220,
              height: 220,
            ),
          ),
        ],
      ),
    );
  }
}
