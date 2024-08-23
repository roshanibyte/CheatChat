import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({super.key});

  @override
  State<QRGenerator> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  final qrDataFeed = TextEditingController();
  String qrData = "https://github.com/ChinmayMunje";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImageView(
                gapless: false,
                embeddedImage: const AssetImage(
                  "assets/googlelogo.png",
                ),
                embeddedImageStyle: const QrEmbeddedImageStyle(
                  size: Size(20, 20),
                ),
                data: qrData,
                size: 160,
                backgroundColor: Colors.white,
                version: QrVersions.auto,
              ),
              const SizedBox(height: 20),
              const Text(
                "Generate QR Code",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0).copyWith(
                  bottom: 0,
                ),
                child: TextField(
                  controller: qrDataFeed,
                  decoration: InputDecoration(
                    hintText: "Enter your link here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (qrDataFeed.text.isEmpty) {
                    setState(() {
                      qrData = "";
                    });
                  } else {
                    setState(
                      () {
                        qrData = qrDataFeed.text;
                      },
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                    color: Colors.blue,
                  ),
                  child: const Text(
                    "Generate QR Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
