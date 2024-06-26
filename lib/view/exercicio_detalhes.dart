import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/exercicio.dart';

class ExercicioDetalhes extends StatelessWidget {
  final Exercicio exercicio;

  ExercicioDetalhes({required this.exercicio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Exercício', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercicio.nome,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Músculo: ${exercicio.musculo}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              exercicio.descricao,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            if (exercicio.imagem.isNotEmpty)
              Center(
                child: CachedNetworkImage(
                  imageUrl: exercicio.imagem,
                  height: 500,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
