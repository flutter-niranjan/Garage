import 'package:flutter/material.dart';

class ExhaustPage extends StatefulWidget {
  const ExhaustPage({super.key});

  @override
  State createState() => _ExhaustPageState();
}

class _ExhaustPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Center(
        child: Text("ExhaustPage"),
      ),
    );
  }
}
