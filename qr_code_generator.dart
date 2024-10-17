import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// This is the screen that you'll see when the app starts
class QRCodeGenerator extends StatefulWidget {
  @override
  State<QRCodeGenerator> createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                  .copyWith(bottom: 40),
              child: TextField(
                onChanged: (value){
                  if(value.isNotEmpty) {
                    setState(() {
                      message=value;
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 280,
                child: QrImageView(
                  data: message,
                  version: QrVersions.auto,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: Color(0xff128760),
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: Color(0xff1a5441),
                  ),
                  embeddedImage:
                      const AssetImage('assets/logo_yakka_transparent.png'),
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size.square(40),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
