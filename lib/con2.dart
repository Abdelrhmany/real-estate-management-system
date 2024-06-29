import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:qr_flutter/qr_flutter.dart';

class EinvoiceGenerator2 extends StatelessWidget {
  const EinvoiceGenerator2(
      {Key? key,
      required this.vatPrice,
      required this.totalWithVat,
      required this.invoiceDate})
      : super(
          key: key,
        );
  final String sellerName = 'ورثة سعيدبن منصور الجشي';
  final String sellerTRN = '310835220600003';
  final String vatPrice;
  final String totalWithVat;
  final String invoiceDate;
  String _getQrCodeContent() {
    final bytesBuilder = BytesBuilder();
//1. Seller Name
    bytesBuilder.addByte(1);
    final sellerNameBytes = utf8.encode(sellerName);
    bytesBuilder.addByte(sellerNameBytes.length);
    bytesBuilder.add(sellerNameBytes);
    // 2. VAT Registration
    bytesBuilder.addByte(2);
    final vatRegistrationBytes = utf8.encode(sellerTRN);
    bytesBuilder.addByte(vatRegistrationBytes.length);
    bytesBuilder.add(vatRegistrationBytes);
    // 3. Time
    bytesBuilder.addByte(3);
    final time = utf8.encode(invoiceDate);
    bytesBuilder.addByte(time.length);
    bytesBuilder.add(time);
    // 4. total with vat
    bytesBuilder.addByte(4);
    final p1 = utf8.encode(totalWithVat);
    bytesBuilder.addByte(p1.length);
    bytesBuilder.add(p1);
    // 5. vat
    bytesBuilder.addByte(5);
    final p2 = utf8.encode(vatPrice);
    bytesBuilder.addByte(p2.length);
    bytesBuilder.add(p2);
    final qrCodeAsBytes = bytesBuilder.toBytes();
    const b64Encoder = Base64Encoder();
    return b64Encoder.convert(qrCodeAsBytes);
  }

  @override
  Widget build(BuildContext context) => QrImageView(
        data: _getQrCodeContent(),
        version: QrVersions.auto,
        size: 100,
      );
}
