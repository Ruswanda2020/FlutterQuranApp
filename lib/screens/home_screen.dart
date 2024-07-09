import 'package:alquran_app/global.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: const SafeArea(child: Text("Home Screen")),
    );
  }
}
