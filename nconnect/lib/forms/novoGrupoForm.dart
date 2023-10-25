import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NovoGrupoFormWidget extends StatefulWidget {
  @override
  _NovoGrupoFormWidgetState createState() => _NovoGrupoFormWidgetState();
}

class _NovoGrupoFormWidgetState extends State<NovoGrupoFormWidget> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nomeGrupoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> emails = [];

  Future<void> adicionarGrupo() async {
    try {
      // Acesse a instância do Firestore
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Crie um mapa com os dados que você deseja salvar
      final Map<String, dynamic> dadosDoGrupo = {
        'Conversas': {
          'Titulo': _nomeGrupoController.text
        },
        'Permissoes': emails,
      };

      // Adicione os dados à coleção "grupos"
      await firestore.collection('chats').add(dadosDoGrupo);

      // O documento foi adicionado com sucesso
      print('Grupo adicionado com sucesso!');
      Navigator.of(context).pop();

    } catch (error) {
      // Lidar com erros, se houver algum
      print('Erro ao adicionar grupo: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Novo Grupo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nomeGrupoController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.group),
                      hintText: 'Escreva aqui',
                      labelText: 'Nome do Grupo',
                    ),
                    onSaved: (String? value) {
                      // Opcional: código a ser executado quando o usuário salvar o formulário.
                    },
                  ),
                  ListTile(
                    onTap: () {
                      final emailToAdd = _searchController.text.trim();
                      if (emailToAdd.isNotEmpty) {
                        setState(() {
                          emails.add(emailToAdd.toLowerCase());
                          _searchController.clear();
                        });
                      }
                    },
                    leading: Icon(Icons.add),
                    title: TextFormField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'exemplo@exemplo.com',
                        labelText: 'Adicionar Pessoas',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: emails.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(emails[index]),
                    trailing: Icon(Icons.delete),
                    onTap: (){
                      emails.remove(emails[index]);
                    },
                  );
                },
              ),
            ),
             ElevatedButton(
              onPressed: () {
                adicionarGrupo();
              },
              child: Text('Salvar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Fechar'),
            ),
          ],
        ),
      ),
    );
  }
}
