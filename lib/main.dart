import 'package:farm_manager/firebase_options.dart';
import 'package:farm_manager/pages/homepage/homepage.dart';
import 'package:farm_manager/pages/login/login.dart';
import 'package:farm_manager/provider/costumer.dart';
import 'package:farm_manager/provider/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  UserProvider userProvider = UserProvider();
  await userProvider.loadUser();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CostumerProvider()),
        ChangeNotifierProvider(create: (_) => userProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    if (user != null) {
      return const MaterialApp(
        title: 'Farm Manager',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      );
    } else {
      return const MaterialApp(
        title: 'Farm Manager',
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      );
    }
  }
}
