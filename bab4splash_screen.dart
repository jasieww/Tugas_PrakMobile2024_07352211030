import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  SplashScreenState createState() => SplashScreenState(); 
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dream.jpg',
              height: 120,
            ),
            const SizedBox(height: 40),
            const Text(
              'Welcome to dream world hihi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}