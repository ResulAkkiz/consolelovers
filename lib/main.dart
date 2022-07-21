import 'package:consolelovers/MyOrderPage.dart';
import 'package:consolelovers/SignInEmailPasswordPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 245, 176, 1),
            appBarTheme:
                const AppBarTheme(color: Color.fromARGB(255, 245, 176, 1)),
            scaffoldBackgroundColor: Colors.blueGrey.shade900),
        title: 'Material App',
        home: const SignInEmailPasswordPage());
  }
}
