import 'package:flutter/material.dart';
import 'package:askida_afet/logo_screen.dart';
import 'package:askida_afet/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Başlangıç ekranı olarak SplashScreen'i kullanıyoruz
      routes: {
        '/loginScreen': (context) => LoginScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/loginScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LogoScreen(), // Başlangıç ekranı olarak LogoScreen'i kullanıyoruz
    );
  }
}