import 'package:dio/dio.dart';
import '../model/exercicio.dart';

class ExercicioDataProvider {
  final Dio dio;

  ExercicioDataProvider({required this.dio});

  Future<List<Exercicio>> getExercicios() async {
    try {
      final response = await dio.get(
        'https://si700-177950-default-rtdb.firebaseio.com/exercicios.json',
      );

      if (response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;
          return data.entries
              .map((entry) => Exercicio.fromMap(entry.value as Map<String, dynamic>, entry.key))
              .toList();
        } else if (response.data is List<dynamic>) {
          final data = response.data as List<dynamic>;
          return data
              .asMap()
              .entries
              .map((entry) => Exercicio.fromMap(entry.value as Map<String, dynamic>, entry.key.toString()))
              .toList();
        } else {
          throw Exception('Formato de dados inesperado');
        }
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao obter exercícios: $e');
      throw e;
    }
  }
}
