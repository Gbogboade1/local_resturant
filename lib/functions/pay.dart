import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import 'package:http/http.dart' as http;
import 'package:jiffy_vi/jiffy.dart';

var secretKey = 'sk_test_fc7475a7c2c4a66b50a62f065984e6d62131e2c0';
Future<String> createAccessCode({getReference, email, amount}) async {
  // skTest -> Secret key
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $secretKey'
  };
  Map data = {"amount": amount, "email": email, "reference": getReference};
  String payload = json.encode(data);
  http.Response response = await http.post(
    'https://api.paystack.co/transaction/initialize',
    headers: headers,
    body: payload,
  );
  final Map rdata = jsonDecode(response.body);
  print(rdata);
  String accessCode = rdata['data']['access_code'];
  return accessCode;
}

Future<bool> payForProduct({
  @required BuildContext context,
  @required int price,
  @required String customerEmail,
}) async {
  try {
    final referenceId = generateRefereceId(
      customerEmail,
      UniqueKey().toString(),
    );
    var acCode = await createAccessCode(
      getReference: referenceId,
      amount: price,
      email: customerEmail,
    );
    Charge charge = Charge()
      ..accessCode = acCode
      ..amount = price
      ..reference = referenceId
      ..email = customerEmail;
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.selectable,
      charge: charge,
    );

    return response.status;
  } catch (e) {
    print("Error...$e");
    return false;
  }
}

String generateRefereceId(customerEmail, uniqueKey) {
  var j = Jiffy();
  return "${j.dateTime.millisecond}_${customerEmail}_$uniqueKey";
}
