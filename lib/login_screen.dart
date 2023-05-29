import 'package:flutter/material.dart';
import 'package:askida_afet/ihtiyac_listesi.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login_screen.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // "İhtiyaç Sahibiyim" butonuna tıklandığında yapılacak işlemler
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IhtiyacListesi(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC85353),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        fixedSize: Size(152, 47)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'İhtiyaç Sahibiyim',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // "Bağışçıyım" butonuna tıklandığında yapılacak işlemler
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC85353),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        fixedSize: Size(152, 47)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Bağışçıyım',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}