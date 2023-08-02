import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class QRCodeToPDFScreen extends StatefulWidget {
  @override
  _QRCodeToPDFScreenState createState() => _QRCodeToPDFScreenState();
}

class _QRCodeToPDFScreenState extends State<QRCodeToPDFScreen> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController dataController =
      TextEditingController(); // New Controller
  List<Uint8List> qrCodes = [];

  Future<void> generateQRCode(int quantity, String data) async {
    qrCodes.clear();
    for (int i = 0; i < quantity; i++) {
      String qrData = '$data $i'; // Modify data for each QR code
      QrPainter painter = QrPainter(
        data: qrData,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );
      ui.PictureRecorder recorder = ui.PictureRecorder();
      Canvas canvas = Canvas(recorder);
      painter.paint(canvas, Size(200, 200));
      ui.Picture picture = recorder.endRecording();
      ui.Image image = await picture.toImage(200, 200); // Await here
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List bytes = byteData!.buffer.asUint8List();
      qrCodes.add(bytes);
    }
    setState(() {});
  }

  Future<void> _saveAsPDF() async {
    final pdf = pw.Document();
    for (int i = 0; i < qrCodes.length; i++) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(pw.MemoryImage(qrCodes[i])),
            );
          },
        ),
      );
    }

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/qr_codes.pdf');
    await file.writeAsBytes(await pdf.save());

    await Printing.sharePdf(
        bytes: await file.readAsBytes(), filename: 'qr_codes.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR Code and PDF'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter quantity:'),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter quantity',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Enter data for QR code:'), // New Text
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                controller: dataController,
                decoration: InputDecoration(
                  hintText: 'Enter data for QR code',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                int quantity = int.tryParse(quantityController.text) ?? 0;
                String data = dataController.text;
                generateQRCode(quantity, data); // Pass the data to the method
              },
              child: Text('Generate QR Codes'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: qrCodes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.memory(qrCodes[index]),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: qrCodes.isEmpty ? null : _saveAsPDF,
              child: Text('Download PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
