import 'package:farm_manager/firebase_options.dart';
import 'package:farm_manager/pages/login/login.dart';
import 'package:farm_manager/provider/costumer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CostumerProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final costumer = Provider.of<CostumerProvider>(context).costumer;
    debugPrint(">> costumer: $costumer");
    return const MaterialApp(
      title: 'Farm Manager',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
