import '../data/treino_data_provider.dart';
import '../model/treino.dart';

class TreinoRepository {
  final TreinoDataProvider dataProvider;

  TreinoRepository({required this.dataProvider});

  Future<void> adicionarTreino(Treino treino) =>
      dataProvider.adicionarTreino(treino);

  Future<void> removerTreino(String id) => dataProvider.removerTreino(id);

  Future<List<Treino>> listarTreinos() => dataProvider.listarTreinos();
}
