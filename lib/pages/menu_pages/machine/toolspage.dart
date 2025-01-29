import 'package:farm_manager/components/side_bar.dart';
import 'package:farm_manager/pages/menu_pages/machine/toolspagelistview.dart';
import 'package:farm_manager/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(),
          // );
        },
        child: Icon(Icons.plus_one,
            color: TAppTheme.appTheme.scaffoldBackgroundColor),
      ),
      backgroundColor: TAppTheme.appTheme.canvasColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: TAppTheme.appTheme.canvasColor),
        child: const ToolsListView(),
      ),
    );
  }
}
