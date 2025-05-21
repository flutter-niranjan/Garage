import 'package:flutter/material.dart';
import 'package:garage/Screens/LoginScreen/login.dart';
import 'package:garage/navBar.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    if (_controller != null) {
      _animation = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeOut,
      ));

      _controller!.forward().whenComplete(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 14.44,
                  top: 49,
                ),
                child: Text(
                  "AUTOMECH",
                  style: GoogleFonts.allertaStencil(
                    fontSize: 40,
                    letterSpacing: 11,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 111,
                  top: 10,
                ),
                child: Image.asset(
                  "assets/SplashScreen/logo.png",
                  colorBlendMode: BlendMode.luminosity,
                ),
              ),
            ],
          ),
          Positioned(
            top: 240,
            left: 1,
            child: Image.asset("assets/SplashScreen/Rectangle.png"),
          ),
          Positioned(
            top: 260,
            left: 12,
            child: SlideTransition(
              position: _animation!,
              child: Image.asset("assets/SplashScreen/splashcar.png"),
            ),
          ),
        ],
      ),
    );
  }
}
