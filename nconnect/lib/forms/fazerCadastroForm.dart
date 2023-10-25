import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nconnect/constants/constants.dart';

class FazerCadastroFormWidget extends StatelessWidget {
  const FazerCadastroFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _EmailController = TextEditingController();
    final TextEditingController _SenhaController = TextEditingController();

    Future<void> cadastrarUsuario() async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _EmailController.text.toLowerCase(),
          password: _SenhaController.text,
        );
        // Registro bem-sucedido
        Fluttertoast.showToast(
          msg: 'Cadastro realizado com sucesso!',
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushNamed(context, '/login');
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Erro no cadastro: $e',
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
              "Cadastro", 
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
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
              controller: _SenhaController, 
            ),
            const SizedBox(height: 50),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => textColor),
                ),
                onPressed: () {
                  cadastrarUsuario();
                },
                child: const Text('Enviar Cadastro', style: TextStyle(color: Colors.white)),
              ),
          ],
        ),
      )
    );
  }
}