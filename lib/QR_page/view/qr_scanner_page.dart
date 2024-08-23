import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/QR_page/view/qr_generator.dart';
import 'package:testapp/QR_page/view/qr_scan_view.dart';

class QrViewPage extends StatefulWidget {
  const QrViewPage({super.key});

  @override
  _QrViewPageState createState() => _QrViewPageState();
}

class _QrViewPageState extends State<QrViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade600,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Display Image
              Image.asset(
                "assets/scanner.png",
                height: 200,
                width: 200,
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Get.to(const QrScanView());
                },
                child: Container(
                  height: 50,
                  width: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: const Text(
                    "Scan Any QR Code..!!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: Colors.indigo[900],
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              InkWell(
                onTap: () {
                  Get.to(
                    const QRGenerator(),
                  );
                },
                child: Container(
                  height: 50,
                  width: 170,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: const Text(
                    "Generate Unique QR Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: Colors.indigo[900],
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
