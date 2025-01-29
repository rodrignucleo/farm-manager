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

class ToolArray {
  final String componente;
  final int intervalo;

  ToolArray({
    required this.componente,
    required this.intervalo,
  });

  factory ToolArray.fromMap(Map<String, dynamic> map) {
    return ToolArray(
      componente: map['componente'] as String,
      intervalo: map['intervalo'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'componente': componente,
      'intervalo': intervalo,
    };
  }

  @override
  String toString() =>
      'Costumer(componente: $componente, intervalo: $intervalo)';
}

class Machine {
  final String costumer;
  final List<MachineArray>? machines;
  final List<ToolArray>? tools;

  Machine({required this.costumer, this.machines, this.tools});

  factory Machine.fromMap(Map<String, dynamic> map) {
    return Machine(
        costumer: map['costumer'] as String,
        machines: (map['machine'] as List<dynamic>?)
                ?.map((machine) =>
                    MachineArray.fromMap(machine as Map<String, dynamic>))
                .toList() ??
            [],
        tools: (map['tool'] as List<dynamic>?)
                ?.map((tool) => ToolArray.fromMap(tool as Map<String, dynamic>))
                .toList() ??
            []);
  }

  Map<String, dynamic> toMap() {
    return {
      'costumer': costumer,
      'machines': machines?.map((machine) => machine.toMap()).toList(),
      'tools': tools?.map((tool) => tool.toMap()).toList(),
    };
  }

  @override
  String toString() =>
      'Costumer(costumer: $costumer, machines: $machines, tools: $tools)';
}
