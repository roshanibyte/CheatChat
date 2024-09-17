import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class QrScanView extends StatefulWidget {
  const QrScanView({super.key});

  @override
  State<QrScanView> createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanView> {
  String qrScannerResult = "Not scanned yet";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        toolbarHeight: 65.h,

        backgroundColor: Colors.grey.shade600,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            const Text(
              " Here is your QR Scan Result",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                // log("nothing ");
                launchUrlString(qrScannerResult);
              },
              child: Text(
                qrScannerResult,
                maxLines: 2,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 15.0,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            InkWell(
              onTap: () async {
                ScanResult codeScanner = await BarcodeScanner.scan(
                  options: const ScanOptions(),
                );
                log(
                  codeScanner.rawContent,
                );
                setState(() {
                  qrScannerResult = codeScanner.rawContent;
                });
              },
              child: Container(
                width: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                height: 50,
                child: const Text(
                  "Open Scanner",
                  style: TextStyle(
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
