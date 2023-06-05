import 'package:askida_afet/ihtiyac_listesi.dart';
import 'package:askida_afet/talep_formu.dart';
import 'package:flutter/material.dart';

class LiveSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF707070),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(), // Geri butonuna tıklanınca önceki sayfaya dön
        ),
        title: Text('Canlı Destek', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF962929),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color(0xFF707070),
              child: Center(
                child: Text(
                  'Buraya canlı destek konuşmaları gelecek',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Mesajınızı buraya yazın...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.black),
                  onPressed: () {
                    // Mesaj gönderme işlemi burada olacak
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.help_outline_outlined,
              size: 30,
            ),
            label: 'Talep Formu',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IhtiyacListesi())
              );
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TalepFormu())
              );
              break;
          }
        },
      ),
    );
  }
}