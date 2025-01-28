import 'package:farm_manager/provider/costumer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final costumer = Provider.of<CostumerProvider>(context).costumer;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF14181B),
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.person),
        // FlutterFlowIconButton(
        //   borderColor: Colors.transparent,
        //   borderRadius: 30,
        //   borderWidth: 1,
        //   buttonSize: 60,
        //   icon: FaIcon(
        //     FontAwesomeIcons.bars,
        //     color: Colors.white,
        //     size: 30,
        //   ),
        //   onPressed: () async {
        //     await showModalBottomSheet(
        //       isScrollControlled: true,
        //       backgroundColor: Colors.transparent,
        //       useSafeArea: true,
        //       context: context,
        //       builder: (context) {
        //         return GestureDetector(
        //           onTap: () {
        //             FocusScope.of(context).unfocus();
        //             FocusManager.instance.primaryFocus?.unfocus();
        //           },
        //           child: Padding(
        //             padding: MediaQuery.viewInsetsOf(context),
        //             child: DropdownWidget(),
        //           ),
        //         );
        //       },
        //     ).then((value) => safeSetState(() {}));
        //   },
        // ),
        title: Text(
          'Bem vindo, ${costumer?.name}',
          style: const TextStyle(color: Color(0xFF8C9EFF)),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: const Color.fromRGBO(20, 24, 27, 1),
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xFF1A237E),
              Color.fromRGBO(20, 24, 27, 1),
              Color(0xFF8C9EFF),
            ],
            begin: AlignmentDirectional(-1, -1),
            end: AlignmentDirectional(1, 1),
          )),
          child: const Text('Welcome'),
        ),
      ),
    );
  }
}
