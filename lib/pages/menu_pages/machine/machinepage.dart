import 'package:farm_manager/components/side_bar.dart';
import 'package:farm_manager/pages/menu_pages/machine/machinelistview.dart';
import 'package:farm_manager/pages/menu_pages/machine/tools/toolsformpage.dart';
import 'package:farm_manager/pages/menu_pages/machine/tools/toolspage.dart';
import 'package:farm_manager/utils/theme/theme.dart';
import 'package:flutter/material.dart';
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

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: SideBar(controller: _controller),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (currentPageIndex == 1) {
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ToolsFormPage(),
                ),
              );
            }
          }
        },
        child: Icon(
          Icons.add,
          color: TAppTheme.appTheme.scaffoldBackgroundColor,
          size: 30,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          navigationBarTheme: TAppTheme.appTheme.navigationBarTheme,
        ),
        child: NavigationBar(
          backgroundColor: TAppTheme.appTheme.scaffoldBackgroundColor,
          indicatorColor: TAppTheme.appTheme.primaryColor,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.minor_crash, color: Color(0xFFFFFFFF)),
              label: 'Máquinas',
            ),
            NavigationDestination(
              icon: Icon(Icons.build, color: Color(0xFFFFFFFF)),
              label: 'Componentes',
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: TAppTheme.appTheme.scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFFFFFFF)),
            onPressed: () {
              _key.currentState?.openDrawer();
            }),
        title: const Text(
          'Suas Máquinas e Ferramentas',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: TAppTheme.appTheme.canvasColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: TAppTheme.appTheme.canvasColor),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: IndexedStack(
                key: ValueKey<int>(currentPageIndex),
                index: currentPageIndex,
                children: const [
                  MachineListView(),
                  ToolsPage(),
                ],
              ),
            )),
      ),
    );
  }
}
