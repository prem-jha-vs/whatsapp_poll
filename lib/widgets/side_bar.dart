import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fun_app/widgets/Text_button.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Sidebar extends StatelessWidget {
  final bool isNewHost;
  final TextEditingController numberController;
  final TextEditingController otpController;
  final VoidCallback onSignUpPressed;
  final VoidCallback onLogInPressed;
  final VoidCallback onGetOTP;

  Sidebar({
    Key? key,
    required this.isNewHost,
    required this.numberController,
    required this.otpController,
    required this.onSignUpPressed,
    required this.onLogInPressed,
    required this.onGetOTP,
  }) : super(key: key);
  var data;
  Future<void> getQrCodeApi() async {
    final response = await http.get(Uri.parse(
        'https://hq8p5sgghg.execute-api.ap-south-1.amazonaws.com/dev/host-sign-in/qr-code'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      //print(data);
    } else {
      throw Exception('Failed to load QR code data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      color: Colors.blue[150],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.12),
          FutureBuilder(
            future: getQrCodeApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return Container(
                  // child: Text(data['message']),
                  child: Image.network(
                    data['data'].toString(),
                    scale: sqrt1_2,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomTextButton(
                  text: 'SignUp',
                  onPressed: onSignUpPressed,
                ),
                CustomTextButton(
                  text: 'LogIn',
                  onPressed: onLogInPressed,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: numberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter Whatsapp Number',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.phone),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: onGetOTP,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                child: const Text(
                  'GetOTP',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
