class Exercicio {
  String id;
  String nome;
  String musculo;
  String descricao;
  String imagem;

  Exercicio({
    required this.id,
    required this.nome,
    required this.musculo,
    required this.descricao,
    required this.imagem,
  });

  factory Exercicio.fromMap(Map<String, dynamic> data, String id) {
    return Exercicio(
      id: id,
      nome: data['nome'] ?? '',
      musculo: data['musculo'] ?? '',
      descricao: data['descricao'] ?? '',
      imagem: data['imagem'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'musculo': musculo,
      'descricao': descricao,
      'imagem': imagem,
    };
  }
}
