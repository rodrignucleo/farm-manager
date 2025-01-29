import 'package:farm_manager/components/side_bar.dart';
import 'package:farm_manager/pages/menu_pages/machine/tools/toolspagelistview.dart';
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
      backgroundColor: TAppTheme.appTheme.canvasColor,
      body: const Center(child: ToolsListView()),
    );
  }
}
