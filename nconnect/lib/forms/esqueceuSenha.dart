import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nconnect/constants/constants.dart';

class EsqueceuSenhaWidget extends StatelessWidget {
  const EsqueceuSenhaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _EmailController = TextEditingController();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    Future<void> resetPassword() async {
      try {
        final email = _EmailController.text.toLowerCase();
        await firebaseAuth.sendPasswordResetEmail(email: email);
        // O documento foi adicionado com sucesso
        Fluttertoast.showToast(
          msg: 'Foi enviado um email de redefinição de senha para o endereço $email. Por favor, verifique sua caixa de entrada e siga as instruções para redefinir sua senha.',
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushNamed(context, '/login');
      } catch (e) {
          Fluttertoast.showToast(
          msg: 'Erro ao enviar o email de redefinição de senha: $e',
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
    
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Redefinir Senha", 
              style: TextStyle(
                color: textColor,
                fontSize: 25,
                fontWeight: FontWeight.w600
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'emxemplo@exemplo.com',
              ),
              controller: _EmailController, 
            ),
            const SizedBox(height: 50),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => textColor),
                ),
                onPressed: () {
                  resetPassword();
                },
                child: const Text('Enviar', style: TextStyle(color: Colors.white)),
              ),
          ],
        ),
      )
    );
  }
}