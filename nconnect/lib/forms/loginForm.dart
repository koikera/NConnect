import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nconnect/constants/constants.dart';
import 'package:nconnect/models/authModel.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final TextEditingController email = TextEditingController();
    final TextEditingController senha = TextEditingController();

    Future<void> signInWithEmailAndPassword() async {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text.toLowerCase(),
            password: senha.text,
          );

          Navigator.pushNamed(context, '/feedbackList');

          // O usuário foi autenticado com sucesso
        } catch (e) {
          // Ocorreu um erro durante a autenticação
          const snackBar = SnackBar(
          backgroundColor: Colors.red,

          content: Text("Usuario nao encontrado!", style: TextStyle(fontSize: 17),),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(e);
        }
      }
    return Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login", 
                    style: TextStyle(
                      color: textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: senha,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Senha',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith((states) => textColor),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.window, color: Colors.white),
                              label: const Text("Microsoft", style: TextStyle(color: Colors.white),),
                          ),
                      ),
                      Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith((states) => textColor),
                              ),
                              onPressed: (){
                                signInWithEmailAndPassword();
                              },
                              child: const Text("Login", style: TextStyle(color: Colors.white),),
                          ),
                      ),
                    ],    
                  ),
                  Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                              ),
                              onPressed: () {},
                              child: const Text("Esqueceu a sua senha?", style: TextStyle(color: textColor),),
                          ),
                      ),
                ],
              ),
            )
          );
  }
}