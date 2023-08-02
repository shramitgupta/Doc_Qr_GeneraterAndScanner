import 'package:flutter/material.dart';
import 'package:scanweb/generater.dart';
import 'package:scanweb/scan.dart';

class Option extends StatefulWidget {
  const Option({super.key});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Option'),
      ),
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRScannerScreen()),
                );
              },
              child: Text('Scanner'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRCodeToPDFScreen()),
                );
              },
              child: Text('Generater'),
            ),
          ],
        ),
      )),
    );
  }
}
