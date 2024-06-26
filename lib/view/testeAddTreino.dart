import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/treino_bloc.dart';
import '../model/treino.dart';

class AddTreino extends StatefulWidget {
  const AddTreino({super.key});
  _AddTreinoState createState() => _AddTreinoState();
}

class _AddTreinoState extends State<AddTreino> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  void _adicionarTreino() {
    final nome = _nomeController.text;
    final descricao = _descricaoController.text;

    if (nome.isNotEmpty && descricao.isNotEmpty) {
      final treino = Treino(
        id: '', // O Firebase irá gerar o IDS
        nome: nome,
        descricao: descricao,
      );

      // Enviar os dados para o Bloc
      context.read<TreinoBloc>().add(AdicionarTreino(treino));

      // Limpar os campos de texto
      _nomeController.clear();
      _descricaoController.clear();

      // Voltar para a tela anterior
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 90),
              Text(
                'Adicionar Treino',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
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
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
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
                width: double.infinity, // mitao pra ser width 100%
                child: ElevatedButton(
                  child:
                      Text('Adicionar', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff003046),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _adicionarTreino,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
