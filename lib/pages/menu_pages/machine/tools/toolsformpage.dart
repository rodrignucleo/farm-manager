import 'package:farm_manager/components/side_bar.dart';
import 'package:farm_manager/pages/menu_pages/machine/machinepage.dart';
import 'package:farm_manager/provider/costumer.dart';
import 'package:farm_manager/service/machineservice.dart';
import 'package:farm_manager/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

class ToolsFormPage extends StatefulWidget {
  const ToolsFormPage({super.key});

  @override
  State<ToolsFormPage> createState() => _ToolsFormPageState();
}

class _ToolsFormPageState extends State<ToolsFormPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _controller = SidebarXController(selectedIndex: 2, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  MachineService machineService = MachineService();
  int currentPageIndex = 0;

  String componenteValue = '';
  String intervaloValue = "";

  @override
  Widget build(BuildContext context) {
    final costumer = Provider.of<CostumerProvider>(context).costumer;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: TAppTheme.appTheme.scaffoldBackgroundColor,
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon:
                  Icon(Icons.menu, color: TAppTheme.appTheme.primaryColorLight),
              onPressed: () {
                _key.currentState?.openDrawer();
              }),
          title: Text(
            'Suas Máquinas e Ferramentas',
            style: TextStyle(color: TAppTheme.appTheme.primaryColorLight),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        key: _key,
        drawer: SideBar(controller: _controller),
        floatingActionButton: ElevatedButton(
          onPressed: () async {
            await machineService.addNewTool(
                context, componenteValue, intervaloValue, costumer!);
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const MachinePage(),
                ),
              );
            }
          },
          child: Icon(Icons.save,
              size: 30, color: TAppTheme.appTheme.scaffoldBackgroundColor),
        ),
        backgroundColor: TAppTheme.appTheme.canvasColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: TAppTheme.appTheme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: TAppTheme.appTheme.primaryColor,
                    blurRadius: 80,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      focusColor: TAppTheme.appTheme.primaryColor,
                      icon: Icon(Icons.build,
                          color: TAppTheme.appTheme.primaryColorLight),
                      labelText: 'Nome do componente',
                      labelStyle: TextStyle(
                          color: TAppTheme.appTheme.primaryColorLight),
                    ),
                    onChanged: (value) {
                      setState(() {
                        componenteValue = value;
                      });
                    },
                  ),
                  TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(Icons.schedule,
                          color: TAppTheme.appTheme.primaryColorLight),
                      labelText: 'Intervalo de horas para reparo',
                      labelStyle: TextStyle(
                          color: TAppTheme.appTheme.primaryColorLight),
                    ),
                    onChanged: (value) {
                      setState(() {
                        intervaloValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
