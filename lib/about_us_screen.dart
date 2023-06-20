import 'package:askida_afet/bagis_listesi.dart';
import 'package:askida_afet/firebase_services.dart';
import 'package:askida_afet/ihtiyac_listesi.dart';
import 'package:askida_afet/login_screen.dart';
import 'package:askida_afet/main.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> with FirebaseService {
  TextEditingController _emailController = TextEditingController();
  String? description;

  @override
  void initState() {
    super.initState();
    fetchAboutUsDescription();
  }

  Future<void> fetchAboutUsDescription() async {
    final desc = await FirebaseService.getAboutUsDesc('about_us_text');
    setState(() {
      description = desc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hakkımızda'),
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description ?? '',
                style: TextStyle(fontSize: 16.8, color: Colors.black),
              ),
              SizedBox(height: 15),
              Center(
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
                        Text(
                          'Ekibimize Katıl',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 13),
                        Text('Mail Adresin:'),
                        SizedBox(height: 8),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'ornek@gmail.com',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color:Color(0xFFCF0000))
                            ),
                          ),
                          cursorColor: Color(0xFFCF0000),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              // Geri dönüş işlemleri
                              await FirebaseService.addMailInTheDrawer('volunteers', _emailController.text);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Teşekkürler!"),
                                    content: Text('Mail adresin ekiplere iletildi. En yakın zamanda geri dönüş alacaksın.'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if(page==0){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => IhtiyacListesi()),
                                            );
                                          } else if (page==1) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => BagisListesi()),
                                            );
                                          }
                                        },
                                        child: Text('Tamam'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFC85353),
                                          padding: EdgeInsets.symmetric(vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFC85353),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            child: Text('Geri Dönüş Yapalım'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: myFab(context),
    );
  }
}
