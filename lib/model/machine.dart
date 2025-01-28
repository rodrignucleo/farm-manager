class Machine {
  final String frota;
  final String modelo;
  final String placa;
  final String responsavel;
  final String costumer;

  Machine({
    required this.frota,
    required this.modelo,
    required this.placa,
    required this.responsavel,
    required this.costumer,
  });

  factory Machine.fromMap(Map<String, dynamic> map) {
    return Machine(
      frota: map['frota'] as String,
      modelo: map['modelo'] as String,
      placa: map['placa'] as String,
      responsavel: map['responsavel'] as String,
      costumer: map['costumer'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'frota': frota,
      'modelo': modelo,
      'placa': placa,
      'responsavel': responsavel,
      'costumer': costumer,
    };
  }

  @override
  String toString() =>
      'Costumer(frota: $frota, modelo: $modelo, placa: $placa, responsavel: $responsavel, costumer: $costumer)';
}
