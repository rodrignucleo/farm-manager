import 'package:farm_manager/model/machine.dart';
import 'package:farm_manager/service/machineservice.dart';
import 'package:farm_manager/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MachineListView extends StatelessWidget {
  const MachineListView({super.key});

  Stream<List<MachineArray>> fetchMachines() {
    MachineService machineService = MachineService();
    return machineService.fetchMachineData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MachineArray>>(
      stream: fetchMachines(),
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
          return const Center(child: Text('Nenhuma máquina encontrada'));
        }

        List<MachineArray> machines = snapshot.data!;

        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: machines.length,
          itemBuilder: (context, index) {
            MachineArray machine = machines[index];
            return Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Modelo: ${machine.modelo}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Placa: ${machine.placa}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Frota: ${machine.frota}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        machine.responsavel == ""
                            ? ""
                            : 'Responsavel: ${machine.responsavel}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
