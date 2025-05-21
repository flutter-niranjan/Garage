import 'package:flutter/material.dart';

class SpoilerPage extends StatefulWidget {
  const SpoilerPage({super.key});

  @override
  State createState() => _SpoilerPageState();
}

class _SpoilerPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("SpoilerPage"),
      ),
    );
  }
}
