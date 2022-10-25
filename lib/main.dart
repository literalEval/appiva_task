import 'package:appiva_task/firebase_options.dart';
import 'package:appiva_task/pages/home_page.dart';
import 'package:appiva_task/pages/login_page.dart';
import 'package:appiva_task/pages/logs_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        HomePage.routeName: ((context) => const HomePage()),
        LoginPage.routeName: ((context) => const LoginPage()),
        LogsPage.routeName: ((context) => const LogsPage()),
      },
    );
  }
}
