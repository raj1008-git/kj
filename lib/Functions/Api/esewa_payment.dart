import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../EventModel/event_model.dart';
import '../authFunctions.dart';

class EsewaService {
  EsewaService({Key? key, required this.event});
  final Event event;

  int randomInt = Random().nextInt(10000000);
  var clientId = "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R";
  var secretKey = "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==";
  var price;

  void useEsewa(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: clientId,
          secretId: secretKey,
        ),
        esewaPayment: EsewaPayment(
          callbackUrl: "",
          productId: "1d71jd81",
          productName: "Product One",
          productPrice: "500",
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) async {
          debugPrint(":::SUCCESS::: => $data");

          await verifyTransactionStatus(data);

          // Create the ticket document in Firestore
          await FirebaseFirestore.instance.collection('tickets').add({
            'userId': authService.userId,
            'eventId': event.documentId,
            'ticketNumber': randomInt,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment successful and ticket created')),
          );
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
  }

  Future<void> verifyTransactionStatus(EsewaPaymentSuccessResult result) async {
    var response = await http.get(
      Uri.parse(
        "https://rc.esewa.com.np/mobile/transaction?txnRefId=${result.refId} ",
      ),
    );
    if (response.statusCode == 200) {
      debugPrint("Response Code => ${response.body}");
    } else {
      debugPrint("Failed to verify transaction");
    }
  }
}
