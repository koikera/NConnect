class DominioModel{
  final String Dominio;
  final String Empresa;
  final DateTime DataCriacao;

  DominioModel({required this.Dominio, required this.Empresa, required this.DataCriacao});

  DominioModel.fromJson(Map<String, Object?> json)
      : this(
          Dominio: json['Dominio']! as String,
          Empresa: json['Empresa']! as String,
          DataCriacao: json['DataCriacao']! as DateTime
        );
  
  Map<String, Object?> toJson() {
    return {
      'Dominio': Dominio,
      'Empresa': Empresa,
      'DataCriacao': DataCriacao
    };
  }
}