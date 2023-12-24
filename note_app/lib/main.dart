import 'package:flutter/material.dart';
import 'package:note_app/pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //init  the hive
  Hive.initFlutter();

  //open the box
  // var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.yellow)),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
