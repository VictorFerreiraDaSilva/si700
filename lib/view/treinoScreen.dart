import 'package:flutter/material.dart';
import 'visualizar_exercicio.dart';

import '../model/treino.dart';

class Exercicio {
  String series;
  String nome;
  int carga;
  bool isSelected;

  Exercicio({
    required this.series,
    required this.nome,
    required this.carga,
    this.isSelected = false,
  });
}

class TreinoScreen extends StatefulWidget {
  final Treino treino;

  TreinoScreen({required this.treino});
  @override
  _TreinoScreenState createState() => _TreinoScreenState(treino: treino);
}

class _TreinoScreenState extends State<TreinoScreen> {
  final Treino treino;
  _TreinoScreenState({required this.treino});

  List<Exercicio> exercicios = [
    Exercicio(series: '4x12', nome: 'Crucifixo Máquina', carga: 21),
    Exercicio(series: '4x12', nome: 'Supino Sentado', carga: 32),
    // Adicione mais exercícios conforme necessário
  ];

  int currentTreinoIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: <Widget>[
            // Botão para o treino anterior
            /*if (currentTreinoIndex > 0)
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    currentTreinoIndex--; // Navegue para o treino anterior
                  });
                },
              ),*/
            Expanded(
              child: Center(child: Text(treino.nome)),
            ),
            // Botão para o próximo treino
            /*if (currentTreinoIndex < 4) // Assumindo que há 5 treinos no total
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    currentTreinoIndex++; // Navegue para o próximo treino
                  });
                },
              ),*/
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: exercicios.map((exercicio) {
                return ListTile(
                  leading: Checkbox(
                    value: exercicio.isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        exercicio.isSelected = value!;
                      });
                    },
                  ),
                  title: Text('${exercicio.series} ${exercicio.nome}'),
                  subtitle: Text('${exercicio.carga}kg'),
                  trailing: Icon(Icons.more_vert),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VisualizarExercicio()),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: TextButton(
              onPressed: () {
                //logica de sair
                Navigator.pop(context);
              },
              child: Text('Fechar Treino', style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
