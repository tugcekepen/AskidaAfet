import 'package:askida_afet/live_support_page.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İletişim'),
        backgroundColor: Color(0xFF962929),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          width: 400,
          child: Center(
            child: Card(
              color: Color(0xFFEDEDED),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'ASKIDA AFET',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 60,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'askidafet@mobile.app.com',
                          style: TextStyle(
                            color: Color(0xFFB4483D),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(
                          Icons.local_phone_outlined,
                          color: Colors.black,
                          size: 60,
                        ),
                        SizedBox(width: 30),
                        Text(
                          '+901111111111',
                          style: TextStyle(
                            color: Color(0xFFB4483D),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Depo Noktaları',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    Column(
                      children: depolar.map((depo) {
                        return ListTile(
                          leading: Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                          ),
                          title: Text(
                            depo,
                            style: TextStyle(color: Color(0xFFB4483D)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 65),
        child: FloatingActionButton(
          onPressed: () {
            // Chatbot ikonuna tıklandığında yapılacak işlemler
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LiveSupportPage()),);
          },
          backgroundColor: Color(0xFFCF0000),
          child: const Icon(
            Icons.support_agent_outlined,
            color: Colors.white,
            size: 45,
          ),
        ),
      ),
    );
  }
}

List<String> depolar = [
  'Ankara Çankaya',
  'Ankara Polatlı',
  'Bursa Harmancık',
  'Çorum Sungurlu',
  'Eskişehir Tepebaşı',
  'İstanbul Avcılar',
  'İstanbul Şişli',
  'İstanbul Üsküdar',
];