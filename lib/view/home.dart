import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'testeAddTreino.dart';
import '../bloc/treino_bloc.dart';
import 'treinoScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Adiciona o evento para listar os treinos quando a tela é inicializada
    context.read<TreinoBloc>().add(ListarTreinos());
  }

  void _atualizarTreinos() {
    context.read<TreinoBloc>().add(ListarTreinos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            Text('Treinos Disponíveis:', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.blue),
            onPressed: _atualizarTreinos,
          ),
        ],
      ),
      body: BlocBuilder<TreinoBloc, TreinoState>(
        builder: (context, state) {
          if (state is TreinoCarregando) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TreinoCarregado) {
            final treinos = state.treinos;
            return ListView.builder(
              itemCount: treinos.length +
                  1, // Adiciona um extra para o botão de adicionar
              itemBuilder: (context, index) {
                if (index == treinos.length) {
                  // Cria um botão para adicionar novos treinos
                  return ListTile(
                    leading: Icon(Icons.add, color: Colors.blue),
                    title: Text('Adicionar treino',
                        style: TextStyle(color: Colors.blue)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddTreino()),
                      );
                    },
                  );
                }
                final treino = treinos[index];
                return ListTile(
                  title: Text(treino.nome),
                  subtitle: Text(treino.descricao),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TreinoScreen(treino: treino)),
                    );
                  },
                );
              },
            );
          } else if (state is TreinoErro) {
            return Center(child: Text(state.mensagem));
          } else {
            return Center(child: Text('Nenhum treino disponível'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _atualizarTreinos,
        child: Icon(Icons.refresh),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
