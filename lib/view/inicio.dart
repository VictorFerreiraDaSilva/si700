import 'package:flutter/material.dart';
import 'cadastro.dart';
import 'login.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60),
              Text(
                'Mago dos Treino',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 60),
              Text(
                'Crie sua conta',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Use seu e-mail para se cadastrar',
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'seu@email.com',
                  filled: true,
                  isDense: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // match_parent
                child: ElevatedButton(
                  child: Text('Cadastrar com e-mail',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff003046),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cadastro()),
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Já tem uma conta? Clique em:',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 8),
              TextButton(
                child: Text(
                  'Já tenho uma conta',
                  style: TextStyle(color: Colors.blueGrey),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
