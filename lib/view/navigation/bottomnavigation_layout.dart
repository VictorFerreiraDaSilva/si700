import 'package:flutter/material.dart';
import '../home.dart';
import '../perfil.dart';
import '../novo_treino.dart';

class BottomNavigationLayout extends StatefulWidget {
  final Map<String, dynamic> user;

  const BottomNavigationLayout({required this.user, super.key});

  @override
  State<BottomNavigationLayout> createState() => _BottomNavigationLayoutState();
}

class _BottomNavigationLayoutState extends State<BottomNavigationLayout> {
  int _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentScreen,
        children: [
          Home(),
          NovoTreino(),
          Perfil(user: widget.user),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: "Novo Treino"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Perfil"),
        ],
        onTap: (value) {
          setState(() {
            _currentScreen = value;
          });
        },
        currentIndex: _currentScreen,
        fixedColor: Colors.cyan,
      ),
    );
  }
}
