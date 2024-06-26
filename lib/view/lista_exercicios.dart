import 'package:flutter/material.dart';

class Exercicio {
  String categoria;
  String nome;

  Exercicio(this.categoria, this.nome);
}

class ListaExercicios extends StatelessWidget {
  final List<Exercicio> exercicios = [
    Exercicio('Peito', 'Crucifixo'),
    Exercicio('Peito', 'Supino Inclinado'),
    Exercicio('Peito', 'Supino Declinado'),
    Exercicio('Peito', 'Supino com Barra'),
    Exercicio('Triceps', 'Triceps Pulley'),
    Exercicio('Triceps', 'Triceps Testa'),
    Exercicio('Triceps', 'Triceps Corda'),
    Exercicio('Biceps', 'Rosca Simultânea'),
    Exercicio('Biceps', 'Rosca 21'),
    Exercicio('Biceps', 'Rosca Barra W'),
    // Adicione mais exercícios conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercícios disponíveis',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: exercicios.length + 1, // Considerando o botão 'Ver mais'
        itemBuilder: (context, index) {
          if (index == exercicios.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: TextButton(
                  child: Text(
                    'Ver Mais',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  onPressed: () {
                    //fazer o ver mais
                  },
                ),
              ),
            );
          }
          Exercicio exercicio = exercicios[index];
          return ListTile(
            title: Text(exercicio.categoria),
            subtitle: Text(exercicio.nome),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Implemente a ação de seleção de um exercício
            },
          );
        },
      ),
    );
  }
}
