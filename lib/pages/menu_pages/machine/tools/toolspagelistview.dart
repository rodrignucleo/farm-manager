import 'package:farm_manager/model/machine.dart';
import 'package:farm_manager/service/machineservice.dart';
import 'package:farm_manager/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ToolsListView extends StatelessWidget {
  const ToolsListView({super.key});

  Stream<List<ToolArray>> fetchToolsData() {
    MachineService machineService = MachineService();
    return machineService.fetchToolsData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ToolArray>>(
      stream: fetchToolsData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitCircle(
            color: TAppTheme.appTheme.canvasColor,
            size: 50.0,
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text(
            'Nenhuma peça encontrada',
            style: TextStyle(color: TAppTheme.appTheme.primaryColorLight),
          ));
        }

        List<ToolArray> tools = snapshot.data!;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Align(
            alignment: Alignment.topCenter,
            child: DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Componente',
                    style:
                        TextStyle(color: TAppTheme.appTheme.primaryColorLight),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Intervalo de Horas',
                    style:
                        TextStyle(color: TAppTheme.appTheme.primaryColorLight),
                  ),
                ),
              ],
              rows: tools.map((tool) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text(tool.componente,
                        style: const TextStyle(color: Colors.white))),
                    DataCell(Text('${tool.intervalo}',
                        style: const TextStyle(color: Colors.white))),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
