import 'package:flutter/material.dart';
import 'package:scanweb/doc.dart';
import 'package:scanweb/generater.dart';
import 'package:scanweb/scan.dart';

class Option extends StatelessWidget {
  const Option({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Image(
                image: AssetImage(
                  'images/Banner.png',
                  // fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QRScannerScreen()),
                        );
                      },
                      child: Text('Scanner'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QRCodeToPDFScreen()),
                        );
                      },
                      child: Text('Generator'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoogleDocOpener()),
                        );
                      },
                      child: Text('Open Google Docs'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
