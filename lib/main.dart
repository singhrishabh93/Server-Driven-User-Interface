import 'package:flutter/material.dart';
import 'package:mirai/mirai.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MiraiApp(
      debugShowCheckedModeBanner: false,
      title: 'Mirai Demo',
      theme: MiraiTheme(primaryColor: "#00a2f9"),
      home: HomeScreen(),
    );
  }
}
