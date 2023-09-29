import 'package:flutter/material.dart';
import 'package:nepalsa/firebase_options.dart';
import 'package:nepalsa/screens/intro.dart';
import 'package:nepalsa/screens/login.dart';
import 'package:nepalsa/screens/message.dart';

import 'package:nepalsa/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Intro(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/message': (context) => Message(),
      },
    );
  }
}
