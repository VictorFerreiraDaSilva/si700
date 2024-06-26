import 'package:dio/dio.dart';
import '../model/treino.dart';

class TreinoDataProvider {
  final Dio dio;

  TreinoDataProvider({required this.dio});

  Future<void> adicionarTreino(Treino treino) async {
    await dio.post(
        'https://si700-177950-default-rtdb.firebaseio.com/treinos.json',
        data: treino.toMap());
  }

  Future<void> removerTreino(String id) async {
    await dio.delete(
        'https://si700-177950-default-rtdb.firebaseio.com/treinos/$id.json');
  }

  Future<List<Treino>> listarTreinos() async {
    try {
      final response = await dio
          .get('https://si700-177950-default-rtdb.firebaseio.com/treinos.json');
      if (response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;
          final treinos = data.entries.map((entry) {
            return Treino.fromMap(
                entry.value as Map<String, dynamic>, entry.key);
          }).toList();
          return treinos;
        } else if (response.data is List<dynamic>) {
          final data = response.data as List<dynamic>;
          final treinos = data.map((item) {
            return Treino.fromMap(
                item as Map<String, dynamic>, item['id'] as String);
          }).toList();
          return treinos;
        } else {
          throw Exception('Formato de dados inesperado');
        }
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao listar treinos: $e');
      rethrow;
    }
  }
}
