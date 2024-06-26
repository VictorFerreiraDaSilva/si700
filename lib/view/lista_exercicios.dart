import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/exercicio_bloc.dart';
import '../repo/exercicio_repository.dart';
import '../model/exercicio.dart';
import 'exercicio_detalhes.dart';

class ListaExercicios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercícios disponíveis', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) {
          final exercicioRepository = RepositoryProvider.of<ExercicioRepository>(context);
          return ExercicioBloc(exercicioRepository: exercicioRepository)..add(FetchExercicios());
        },
        child: BlocBuilder<ExercicioBloc, ExercicioState>(
          builder: (context, state) {
            if (state is ExercicioLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ExercicioLoaded) {
              final exercicios = state.exercicios;
              return ListView.builder(
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
                    title: Text(exercicio.nome),
                    subtitle: Text(exercicio.musculo),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExercicioDetalhes(exercicio: exercicio),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is ExercicioError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Nenhum exercício disponível'));
            }
          },
        ),
      ),
    );
  }
}
