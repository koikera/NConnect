import 'package:flutter/material.dart';
import 'package:nconnect/constants/constants.dart';

class DominioWidget extends StatelessWidget {
  const DominioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("N-Connect", style: TextStyle(color: textColor, fontWeight: FontWeight.w700),),
        backgroundColor: primary,
      ),
      body: Center(
        child:  Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 const Text(
                    "Domínio", 
                    style: TextStyle(
                      color: textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Dominio@empresa.com',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => textColor),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text("Avancar", style: TextStyle(color: Colors.white),),
                      ),
                  ),
                ]
              )
            )

          )
      )
    );;
  }
}