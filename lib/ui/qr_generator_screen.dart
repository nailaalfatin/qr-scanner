import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  String? qrRawValue; // default qr text kosong
  Color qrColor = Colors.black; // default warna qr
  String? selectedQrType; // value buat tipe QR
  final List<String> qrTypes = ['PNG', 'SVG', 'JPG', 'PDF']; // opsi dropdown
  ScreenshotController screenshotController = ScreenshotController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // warna abu terang
      appBar: AppBar(
        title: const Text(
          "Create",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF553FB8), // warna ungu header
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // bg ungu di atas
              Container(
                height: 300,
                color: const Color(0xFF553FB8),
              ),
              // sisanya warna putih
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // Menjaga QR Code dan konten lainnya tetap terletak di atas Stack
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                      right: 20,
                      bottom: 0
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: qrRawValue == null
                              ? null
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: qrColor, width: 4),
                                ),
                          child: qrRawValue == null
                              ? const Text(
                                  "No QR Code Generated",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              : Screenshot(
                                controller: screenshotController,
                                child: PrettyQr(
                                  data: qrRawValue!,
                                  size: 150,
                                  roundEdges: true,
                                  elementColor: Colors.black,
                                ),
                              ),
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: "Link",
                            hintText: "Insert link here...",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              qrRawValue = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 56),
                          child: DropdownButtonHideUnderline(
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: "QR Code Type",
                                border: OutlineInputBorder(),
                              ),
                              child: DropdownButton<String>(
                                value: selectedQrType,
                                hint: const Text('Select QR Code Type'),
                                isExpanded: true,
                                isDense: true,
                                items: qrTypes.map((type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(type),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedQrType = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var color in [
                              Colors.red,
                              Colors.orange,
                              Colors.yellow,
                              Colors.green,
                              Colors.cyan,
                              Colors.purple
                            ])
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    qrColor = color;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: qrColor == color
                                          ? Colors.white
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    qrRawValue = null;
                                  });
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              color: Colors.grey.shade300,
                              height: 50,
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: _shareQrCode,
                                child: const Text(
                                  "Share",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareQrCode() async {
    // ambil screenshot dari QR
    final image = await screenshotController.capture();
    if (image != null) {
      // kalau berhasil ambil gambar, share menggunakan Share Plus
      await Share.shareXFiles([
        XFile.fromData(
          image,
          name: "qr_code.png", // nama file screenshot
          mimeType: "image/png", // format file
        ),
      ]);
    }
  }
}
