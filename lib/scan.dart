import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool isCameraGranted = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null && scanData.format == BarcodeFormat.qrcode) {
        _openGoogleDoc(scanData.code.toString());
      }
    });
  }

  Future<void> _openGoogleDoc(String qrContent) async {
    // Assuming the QR code contains a valid Google Doc URL
    final googleDocUrl = qrContent;

    if (await canLaunch(googleDocUrl)) {
      await launch(googleDocUrl);
    } else {
      print("Error opening Google Doc");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                Positioned(
                  bottom: 20,
                  child: Text(
                    'Align the QR code within the frame to scan',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  var status = await Permission.camera.request();
                  setState(() {
                    isCameraGranted = status.isGranted;
                  });
                },
                child: Text('Allow Camera Access'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
