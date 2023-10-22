import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nconnect/constants/constants.dart';
import 'package:nconnect/models/dominioModel.dart';


class DominioWidget extends StatelessWidget {
  const DominioWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final TextEditingController _searchController = TextEditingController();

    void _performSearch() {
    final String query = _searchController.text;
    firestore.collection('dominios').where('Dominio', isEqualTo: query).get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Se pelo menos um documento corresponder ao nome, navegue para outra tela
        Navigator.pushNamed(context, '/login');
      } else {
        const snackBar = SnackBar(
          backgroundColor: Colors.red,

          content: Text('Dominio não encontrado, contate um administrador', style: TextStyle(fontSize: 17),),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

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
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Dominio@empresa.com'
                    ),
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Este campo não pode estar vazio.";
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
                            _performSearch();
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