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

  void _removeNote(String note) {
    context.read<AuthBloc>().add(RemoveNote(widget.userId, note));
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
    context.read<AuthBloc>().add(AuthUserUpdated(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackButtonPressed();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Anotações'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _onBackButtonPressed,
          ),
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
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeNote(state.notes[index]),
                          ),
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
      ),
    );
  }
}
