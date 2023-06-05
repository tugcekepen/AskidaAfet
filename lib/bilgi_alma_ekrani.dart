import 'package:flutter/material.dart';

class BilgiAlmaEkrani extends StatefulWidget {
  @override
  _BilgiAlmaEkraniState createState() => _BilgiAlmaEkraniState();
}

class _BilgiAlmaEkraniState extends State<BilgiAlmaEkrani> {
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController adresController = TextEditingController();
  TextEditingController tcKimlikNoController = TextEditingController();

  @override
  void dispose() {
    adSoyadController.dispose();
    telefonController.dispose();
    adresController.dispose();
    tcKimlikNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'ASKIDA AFET',
          style: TextStyle(
            color: Color(0xFF3B3B3B),
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xFF3B3B3B), // Geri butonunun rengi
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        // Sayfayı kaydırılabilir hale getirir
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  'Bağış Formu',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 5,
                color: Color(0xFFCF0000),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFF4F4F4),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        onTap: () {
                          FocusScope.of(context).unfocus(); // TextField focusundan çık
                        },
                        controller: adSoyadController,
                        cursorColor: Color(0xFFCF0000),
                        decoration: InputDecoration(
                          labelText: 'Ad Soyad',
                          hintText: '*Zorunlu Alan',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 116, 113, 113) ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Color(0xFFCF0000)), // Odaklandığında kullanılacak kenarlık rengi
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        onTap: () {
                          FocusScope.of(context).unfocus(); // TextField focusundan çık
                        },
                        cursorColor: Color(0xFFCF0000),
                        controller: tcKimlikNoController,
                        decoration: InputDecoration(
                          labelText: 'TC Kimlik No',
                          hintText: '*Zorunlu Alan',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 116, 113, 113) ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Color(0xFFCF0000)), // Odaklandığında kullanılacak kenarlık rengi
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        onTap: () {
                          FocusScope.of(context).unfocus(); // TextField focusundan çık
                        },
                        cursorColor: Color(0xFFCF0000),
                        controller: telefonController,
                        decoration: InputDecoration(
                          labelText: 'Telefon Numarası',
                          hintText: '*Zorunlu Alan',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 116, 113, 113) ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Color(0xFFCF0000)), // Odaklandığında kullanılacak kenarlık rengi
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        onTap: () {
                          FocusScope.of(context).unfocus(); // TextField focusundan çık
                        },
                        cursorColor: Color(0xFFCF0000),
                        controller: adresController,
                        decoration: InputDecoration(
                          labelText: 'Adres',
                          hintText: '*Zorunlu Alan',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 116, 113, 113) ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Color(0xFFCF0000)), // Odaklandığında kullanılacak kenarlık rengi
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            String adSoyad = adSoyadController.text;
                            String tcKimlikNo = tcKimlikNoController.text;
                            String telefon = telefonController.text;
                            String adres = adresController.text;
                            final snackBar = SnackBar(
                              content: Text('Kargo en yakın zamanda gönderilecek'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC85353),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),// Butonun arka plan rengi
                          ),
                          child: Text('Adrese Kargo İste'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}