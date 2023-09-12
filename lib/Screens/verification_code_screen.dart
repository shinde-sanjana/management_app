import 'package:flutter/material.dart';

import '../login/login_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late TextEditingController _verificationCodeController;
  // late String _newPassword;
  // late String _confirmPassword;

  @override
  void initState() {
    super.initState();
    _verificationCodeController = TextEditingController();
  }

  @override
  void dispose() {
    _verificationCodeController.dispose();
    super.dispose();
  }

  void _verifyCode() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Verification Screen'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                    "assets/images/logo_for_letterhead-removebg-preview.png")),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 190),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      //height: 50,
                      child: Text(
                        'Verify that its you\nWe have sent a verification code to your phone number linked to this account.',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 97, 8, 119),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70.0),
                    TextFormField(
                      cursorColor: const Color.fromARGB(255, 97, 8, 119),
                      controller: _verificationCodeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Verification Code',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 97, 8, 119),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromARGB(255, 97, 8, 119),
                          width: 2,
                        )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 97, 8, 119),
                                width: 2)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: const Color.fromARGB(255, 97, 8, 119),
                      controller: _verificationCodeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 97, 8, 119),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromARGB(255, 97, 8, 119),
                          width: 2,
                        )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 97, 8, 119),
                                width: 2)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: const Color.fromARGB(255, 97, 8, 119),
                      controller: _verificationCodeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 97, 8, 119),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromARGB(255, 97, 8, 119),
                          width: 2,
                        )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 97, 8, 119),
                                width: 2)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        _verifyCode();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FormScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 97, 8, 119),
                      ),
                      child: const Text('Verify'),
                    ),
                    // SizedBox(height: 10.0),
                    // TextField(
                    //   decoration: InputDecoration(labelText: 'New Password'),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _newPassword = value;
                    //     });
                    //   },
                    // ),
                    // SizedBox(height: 10.0),
                    // TextField(
                    //   decoration:
                    //       const InputDecoration(labelText: 'Confirm Password'),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _confirmPassword = value;
                    //     });
                    //   },
                    // ),
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
