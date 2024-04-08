import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  String otpSent = '';

  Future<void> sendOTP() async {
    final phoneNumber = phoneNumberController.text;
    final response = await http.post(
      Uri.parse('endpoint/send-otp'),
      body: jsonEncode({'phoneNumber': phoneNumber}),
    );

    if (response.statusCode == 200) {
      setState(() {
        otpSent = 'OTP sent to $phoneNumber';
      });
    } else {
      setState(() {
        otpSent = 'Failed to send OTP';
      });
    }
  }

  Future<void> verifyOTP() async {
    String phoneNumber = phoneNumberController.text;
    String otp = otpController.text;
    final response = await http.post(
      Uri.parse('YOUR_BACKEND_ENDPOINT/verify-otp'),
      body: jsonEncode({'phoneNumber': phoneNumber, 'otp': otp}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // OTP matched, phone number verified
      // You can navigate to the next screen or perform any other action
      print('Phone number verified');
    } else {
      print('OTP verification failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendOTP,
              child: const Text('Send OTP'),
            ),
            Text(otpSent),
            const SizedBox(height: 20),
            TextFormField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter OTP'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyOTP,
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
