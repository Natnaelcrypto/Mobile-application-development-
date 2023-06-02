import 'package:flutter/material.dart';

import 'Start_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Startpage();
  }
}
