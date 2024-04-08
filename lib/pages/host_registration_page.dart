import 'package:flutter/material.dart';
import 'package:fun_app/pages/host_dashboard.dart';
import 'package:fun_app/widgets/side_bar.dart';

class HostRegistrationPage extends StatefulWidget {
  const HostRegistrationPage({Key? key}) : super(key: key);

  @override
  _HostRegistrationPageState createState() => _HostRegistrationPageState();
}

class _HostRegistrationPageState extends State<HostRegistrationPage> {
  bool isNewHost = false;
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue[50],
        child: Row(
          children: <Widget>[
            Sidebar(
              isNewHost: isNewHost,
              numberController: numberController,
              otpController: otpController,
              onSignUpPressed: () {
                setState(() {
                  isNewHost = true;
                });
              },
              onLogInPressed: () {
                setState(() {
                  isNewHost = false;
                });
              },
              onGetOTP: () {
                print('clicked');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HostDashboard()),
                );
              },
            ),
            // Main Content
            Expanded(
              child: Container(
                color: Colors.blue[200],
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      decoration: BoxDecoration(color: Colors.blue[50]),
                      child: const Row(
                        children: <Widget>[
                          Text(
                            'WhatsApp Poll',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(color: Colors.blue[200]),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome Text',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 32,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Discription about the app',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
