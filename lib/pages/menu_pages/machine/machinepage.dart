import 'package:farm_manager/components/side_bar.dart';
import 'package:farm_manager/pages/menu_pages/machine/machinelistview.dart';
import 'package:farm_manager/provider/costumer.dart';
import 'package:farm_manager/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

class MachinePage extends StatefulWidget {
  const MachinePage({super.key});

  @override
  State<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends State<MachinePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: SideBar(controller: _controller),
      appBar: AppBar(
        backgroundColor: TAppTheme.appTheme.scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFFFFFFF)),
            onPressed: () {
              _key.currentState?.openDrawer();
            }),
        title: const Text(
          'Máquinas',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: TAppTheme.appTheme.primaryColorDark,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: TAppTheme.appTheme.primaryColorDark),
        child: const MachineListView(),
      ),
    );
  }
}
