import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method
import '../bloc/auth_bloc.dart';
import 'navigation/bottomnavigation_layout.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});
  CadastroState createState() => CadastroState();
}

class CadastroState extends State<Cadastro> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  void _register() {
    final nome = nomeController.text;
    final usuario = usuarioController.text;
    final email = emailController.text;
    final senha = senhaController.text;

    if (nome.isNotEmpty && usuario.isNotEmpty && email.isNotEmpty && senha.isNotEmpty) {
      final userId = email.hashCode.toString(); // Use a hash do email como userId
      final senhaMd5 = md5.convert(utf8.encode(senha)).toString(); // Criptografa a senha com MD5
      context.read<AuthBloc>().add(AuthRegister(userId: userId, email: email, nome: nome, usuario: usuario, senha: senhaMd5));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, preencha todos os campos')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, atleta!', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationLayout(user: state.user),
              ),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text('Preencha o formulário para se cadastrar:', style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
              Text('Nome Completo:', style: TextStyle(fontSize: 16)),
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  hintText: 'Preencha com seu nome completo',
                ),
              ),
              SizedBox(height: 20),
              Text('Usuário:', style: TextStyle(fontSize: 16)),
              TextField(
                controller: usuarioController,
                decoration: InputDecoration(
                  hintText: 'Insira seu nome de usuário para o app',
                ),
              ),
              SizedBox(height: 20),
              Text('Email:', style: TextStyle(fontSize: 16)),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Digite seu email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              Text('Senha:', style: TextStyle(fontSize: 16)),
              TextField(
                controller: senhaController,
                decoration: InputDecoration(
                  hintText: 'Digite sua senha',
                ),
                obscureText: true,
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  child: Text('Cadastrar', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff003046),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
