import 'package:farm_manager/components/side_bar.dart';
import 'package:farm_manager/provider/costumer.dart';
import 'package:farm_manager/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final costumer = Provider.of<CostumerProvider>(context).costumer;

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
        title: Text(
          'Bem vindo, ${costumer?.name}',
          style: const TextStyle(color: Color(0xFFFFFFFF)),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: const Color.fromRGBO(20, 24, 27, 1),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              TAppTheme.appTheme.canvasColor,
              Color.fromRGBO(20, 24, 27, 1),
              TAppTheme.appTheme.primaryColor,
            ],
            begin: AlignmentDirectional(-1, -1),
            end: AlignmentDirectional(1, 1),
          )),
          child: Center(
              child: Text(
            'Welcome',
            style: TextStyle(color: TAppTheme.appTheme.primaryColor),
          )),
        ),
      ),
    );
  }
}
