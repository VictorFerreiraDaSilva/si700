import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

class NotesScreen extends StatefulWidget {
  final String userId;

  const NotesScreen({required this.userId, super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(GetNotes(widget.userId));
  }

  void _addNote() {
    final note = _noteController.text;
    if (note.isNotEmpty) {
      context.read<AuthBloc>().add(AddNote(widget.userId, note));
      _noteController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anotações'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthNotesLoaded) {
                  return ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.notes[index]),
                      );
                    },
                  );
                } else if (state is AuthLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text('Erro ao carregar anotações'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      labelText: 'Nova anotação',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addNote,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
