import 'package:askida_afet/firebase_services.dart';
import 'package:askida_afet/main.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İletişim'),
        backgroundColor: Color(0xFF962929),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white, // Geri butonunun rengi
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                        SizedBox(width: 16),
                        TextButton(
                          onPressed: () {
                            commandLaunch(
                                'mailto:askidafet@mobile.app.com?subject=Mail%20konunuzu%20buraya%20yazın%20&body=Merhaba%20Askıda%20Afet%20ekibi,');
                          },
                          child: Text(
                            'askidafet@mobile.app.com',
                            style: TextStyle(
                              color: Color(0xFFB4483D),
                              fontSize: 15,
                            ),
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
                        TextButton(
                          onPressed: () {
                            commandLaunch('tel:+90 111 111 11 11');
                          },
                          child: Text(
                            '+901111111111',
                            style: TextStyle(
                              color: Color(0xFFB4483D),
                              fontSize: 20,
                            ),
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
                    FutureBuilder<Map<String, dynamic>>(
                      future: FirebaseService.getAllStores(),
                      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Veriler yüklenirken bir hata oluştu.');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        Map<String, dynamic>? data = snapshot.data;

                        if (data == null || data.isEmpty) {
                          return Text('Veri bulunamadı.');
                        }

                        List<String> sortedKeys = data.keys.toList()..sort();

                        List<Widget> depolar = [];

                        sortedKeys.forEach((key) {
                          depolar.add(
                            ListTile(
                              onTap: () {
                                String location = key;
                                commandLaunch('https://www.google.com/maps/search/?api=1&query=$location');
                              },
                              leading: Icon(
                                Icons.location_on_outlined,
                                color: Colors.black,
                              ),
                              title: Text(
                                key,
                                style: TextStyle(color: Color(0xFFB4483D)),
                              ),
                              subtitle: Text(
                                data[key],
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          );
                        });

                        return Column(
                          children: depolar,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: myFab(context),
    );
  }
}