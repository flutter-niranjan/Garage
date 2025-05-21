import 'package:flutter/material.dart';

class BumperPage extends StatefulWidget {
  const BumperPage({super.key});

  @override
  State createState() => _BumperPageState();
}

class _BumperPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("BumperPage"),
      ),
    );
  }
}
