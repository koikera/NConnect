import 'package:flutter/material.dart';
import 'package:nconnect/constants/constants.dart';
import 'package:nconnect/forms/loginForm.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("N-Connect", style: TextStyle(color: textColor, fontWeight: FontWeight.w700),),
        backgroundColor: primary,
      ),
      body: const Center(
        child:  LoginFormWidget()
      )
    );
  }
}