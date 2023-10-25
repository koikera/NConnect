import 'package:flutter/material.dart';
import 'package:nconnect/constants/constants.dart';
import 'package:nconnect/forms/esqueceuSenha.dart';

class ResetSenhaWidget extends StatelessWidget {
  const ResetSenhaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("PsychaPraise", style: TextStyle(color: textColor, fontWeight: FontWeight.w700),),
        backgroundColor: primary,
      ),
      body: const Center(
        child:  EsqueceuSenhaWidget()
      )
    );
  }
}