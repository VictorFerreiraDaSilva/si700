import 'package:flutter/material.dart';
import 'lista_exercicios.dart';

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

class NovoTreino extends StatefulWidget {
  @override
  _NovoTreinoState createState() => _NovoTreinoState();
}

class _NovoTreinoState extends State<NovoTreino> {
  List<Exercicio> exercicios = [
    Exercicio(series: '4x12', nome: 'Crucifixo Máquina', carga: 21),
    Exercicio(series: '4x12', nome: 'Supino Sentado', carga: 32),
    // Adicione mais exercícios conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Novo Treino', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
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
                    // Implementar lógica para editar exercício, se necessário
                  },
                );
              }).toList(),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              child: Text('Ver lista de exercícios',
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaExercicios()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff003046),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
