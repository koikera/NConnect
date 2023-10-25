import 'package:flutter/material.dart';
import 'package:nconnect/constants/constants.dart';
import 'package:nconnect/forms/fazerCadastroForm.dart';

class FazerCadastroWidget extends StatelessWidget {
  const FazerCadastroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PsychaPraise", style: TextStyle(color: textColor, fontWeight: FontWeight.w700),),
        backgroundColor: primary,
      ),
      body: const Center(
        child:  FazerCadastroFormWidget()
      )
    );
  }
}