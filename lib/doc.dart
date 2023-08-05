import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleDocOpener extends StatelessWidget {
  final String docUrl = 'https://www.google.com/docs/about/';

  void _openGoogleDoc() async {
    try {
      if (await canLaunch(docUrl)) {
        await launch(docUrl);
      } else {
        print('Could not launch $docUrl');
      }
    } catch (e) {
      print('Error launching $docUrl: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _openGoogleDoc,
      child: Text('Open Google Docs'),
    );
  }
}
