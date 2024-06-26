class Treino {
  final String id;
  final String nome;
  final String descricao;

  Treino({required this.id, required this.nome, required this.descricao});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
    };
  }

  factory Treino.fromMap(Map<String, dynamic> map, String id) {
    return Treino(
      id: id,
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
    );
  }
}
