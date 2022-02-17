import 'dart:io';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   setState(() {
  //     this.controller = controller;
  //   });
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       result = scanData;
  //     });
  //   });
  // }

  // For QR Code Scanner
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (await canLaunch(scanData.code.toString())) {
        await launch(scanData.code.toString());
        controller.resumeCamera();
        debugPrint(scanData.code);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              alignment: Alignment.center,
              contentPadding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 10.0),
              insetPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.15,
                vertical: MediaQuery.of(context).size.height * 0.3,
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Icon(
                Icons.info_outline,
                size: 40,
                color: kYellow,
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Not a verified streato member. Discard it!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListBody(
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Code Type: ${describeEnum(scanData.format).toUpperCase()}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Data: ${scanData.code}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      // color: Colors.black,
                      color: Color.fromRGBO(67, 73, 101, 1),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.66,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    onPermissionSet: (ctrl, p) =>
                        _onPermissionSet(context, ctrl, p),
                    overlay: QrScannerOverlayShape(
                      borderColor: Color(0xFFFAB84C),
                      borderLength: 25,
                      borderRadius: 11,
                      borderWidth: 11,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              child: CircleAvatar(
                backgroundColor: Color(0xFFFAB84C),
                radius: 33,
                child: Center(
                  child: Icon(
                    Icons.highlight,
                    color: Colors.white,
                    size: 35,
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
