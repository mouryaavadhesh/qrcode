import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrcode/qr_code_generator.dart';
import 'package:qrcode/qr_code_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    requestPermission();
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Demo')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                checkPermissionStatus().then((value) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QRViewExample(),
                  ));
                });
              },
              child: const Text('qrView'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QRCodeGenerator(),
                ));
              },
              child: const Text('qr code generator'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                requestPermission();
              },
              child: const Text('Request Camera Permission'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> requestPermission() async {
    await Permission.camera
        .onDeniedCallback(() async {
          await Permission.camera.request();
          requestPermission();
        })
        .onGrantedCallback(() {})
        .onPermanentlyDeniedCallback(() {
          openAppSettings();
        })
        .onRestrictedCallback(() {
          openAppSettings();
        })
        .onLimitedCallback(() {
          openAppSettings();
        })
        .onProvisionalCallback(() {
          openAppSettings();
        })
        .request();
  }

  Future<bool> checkPermissionStatus() async {
    const permission = Permission.camera;

    return await permission.status.isGranted;
  }
}
