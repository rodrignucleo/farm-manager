class MachineArray {
  final String frota;
  final String modelo;
  final String placa;
  final String? responsavel;

  MachineArray({
    required this.frota,
    required this.modelo,
    required this.placa,
    this.responsavel,
  });

  factory MachineArray.fromMap(Map<String, dynamic> map) {
    return MachineArray(
      frota: map['frota'] as String,
      modelo: map['modelo'] as String,
      placa: map['placa'] as String,
      responsavel: map['responsavel'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'frota': frota,
      'modelo': modelo,
      'placa': placa,
      'responsavel': responsavel,
    };
  }

  @override
  String toString() =>
      'Costumer(frota: $frota, modelo: $modelo, placa: $placa, responsavel: $responsavel)';
}

class Machine {
  final String costumer;
  final List<MachineArray>? machines;

  Machine({
    required this.costumer,
    this.machines,
  });

  factory Machine.fromMap(Map<String, dynamic> map) {
    return Machine(
        costumer: map['costumer'] as String,
        machines: (map['machine'] as List<dynamic>?)
                ?.map((machine) =>
                    MachineArray.fromMap(machine as Map<String, dynamic>))
                .toList() ??
            []);
  }

  Map<String, dynamic> toMap() {
    return {
      'costumer': costumer,
      'machines': machines?.map((machine) => machine.toMap()).toList(),
    };
  }

  @override
  String toString() => 'Costumer(costumer: $costumer, machines: $machines)';
}
