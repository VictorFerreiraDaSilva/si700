import '../data/exercicio_data_provider.dart';
import '../model/exercicio.dart';

class ExercicioRepository {
  final ExercicioDataProvider exercicioDataProvider;

  ExercicioRepository({required this.exercicioDataProvider});

  Future<List<Exercicio>> getExercicios() async {
    return await exercicioDataProvider.getExercicios();
  }
}
