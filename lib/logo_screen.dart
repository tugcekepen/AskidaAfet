import 'package:flutter/material.dart';
import 'package:askida_afet/ihtiyac_listesi.dart';

class LogoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/logo_screen.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            color: Colors.black.withOpacity(0.2), // Arka plan rengi ve opaklık değeri
          ),
        ],
      ),
    );
  }
}