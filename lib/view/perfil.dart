import 'package:flutter/material.dart';
import 'editar_perfil.dart';
import 'inicio.dart';

class Perfil extends StatefulWidget {
  final Map<String, dynamic> user;

  const Perfil({required this.user, super.key});

  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  void _navigateToEdit(String field, String value) {
    final userId = widget.user['userId'];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile(field: field, value: value, userId: userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Informações', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 24.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.cyan.shade800,
                  child: Text(user['nome']?.substring(0, 1) ?? 'N'), // Primeira letra do nome
                ),
                SizedBox(height: 8),
                Text('Editar foto de perfil', style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Nome'),
            subtitle: Text(user['nome'] ?? ''),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => _navigateToEdit('nome', user['nome'] ?? ''),
          ),
          ListTile(
            title: Text('Usuário'),
            subtitle: Text('@${user['usuario'] ?? ''}'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => _navigateToEdit('usuario', user['usuario'] ?? ''),
          ),
          ListTile(
            title: Text('Email'),
            subtitle: Text(user['email'] ?? ''),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => _navigateToEdit('email', user['email'] ?? ''),
          ),
          ListTile(
            title: Text('Treinos Cadastrados'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Treino A - Peito e Ombro'),
                Text('Treino B - Inferiores'),
                Text('Treino C - Bíceps e Tríceps'),
              ],
            ),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.add, color: Colors.blue),
              onPressed: () {
                // Navegue para a tela de adicionar treino
              },
            ),
          ),
          ListTile(
            title: Text('Anotações'),
            subtitle: Text('Anotações do usuário sobre suas metas ou observações gerais.'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navegue para a tela de anotações
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: TextButton(
              onPressed: () {
                // Lógica de sair
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Inicio()),
                );
              },
              child: Text('Sair', style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
