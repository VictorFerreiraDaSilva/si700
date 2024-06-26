import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

class EditarPerfil extends StatefulWidget {
  final String field;
  final String value;
  final String userId;

  const EditarPerfil({required this.field, required this.value, required this.userId, super.key});

  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  void _save() {
    final newValue = _controller.text;
    if (newValue.isNotEmpty) {
      context.read<AuthBloc>().add(UpdateUserField(widget.userId, widget.field, newValue));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, preencha o campo')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar ${widget.field}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(widget.field, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _save,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
