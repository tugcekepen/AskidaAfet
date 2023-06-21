import 'package:askida_afet/bagis_listesi.dart';
import 'package:askida_afet/login_screen.dart';
import 'package:askida_afet/main.dart';
import 'package:flutter/material.dart';
import 'package:askida_afet/firebase_services.dart';
import 'package:askida_afet/shopping_cart_ihtiyac.dart';

TextEditingController _adSoyadController = TextEditingController();
TextEditingController _telefonController = TextEditingController();
TextEditingController _mailController = TextEditingController();
TextEditingController _adresController = TextEditingController();
TextEditingController _tcKimlikNoController = TextEditingController();
TextEditingController _bagislarController = TextEditingController();

class BagisFormu extends StatefulWidget {
  @override
  _BilgiAlmaEkraniState createState() => _BilgiAlmaEkraniState();
}

class _BilgiAlmaEkraniState extends State<BagisFormu> with FirebaseService {
  final _formKey = GlobalKey<FormState>();

  void sendFormToFirebase() {
    String girdi = _bagislarController.text;
    List<String> bagislar = girdi.split(',');
    bagislar = bagislar.map((bagis) => bagis.trim()).toList();

    final formValues = {
      'tc_no': _tcKimlikNoController.text,
      'bagislar': bagislar,
      'ad_soyad': _adSoyadController.text,
      'adres': _adresController.text,
      'mail': _mailController.text,
      'telefon': _telefonController.text,
    };

    sendFormData(formValues, 'bagis_forms')
        .then((_) {
      // Gönderme işlemi başarılı olduğunda yapılacak işlemler
      cartItemsB = {};
      _tcKimlikNoController.text = "";
      _bagislarController.text = "";
      _adSoyadController.text = "";
      _adresController.text = "";
      _mailController.text= "";
      _telefonController.text = "";
      final snackBar = SnackBar(
        duration: const Duration(milliseconds: 800),
        content: Text('Form başarıyla gönderildi'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    })
        .catchError((error) {
      // Gönderme işlemi sırasında bir hata oluştuğunda yapılacak işlemler
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Form gönderilirken bir hata oluştu. Tekrar deneyin.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    });
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BagisListesi()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        // Sayfayı kaydırılabilir hale getirir
        child: Form(
          key: _formKey,
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
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFF4F4F4),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Bağış İhtiyaç Listesinde bulamadığınız ürünleri "Bağışlar" başlığı altına ve aralarına virgül koyarak yazınız.',
                        ),
                        TextFormField(
                          onTap: () {
                            FocusScope.of(context).unfocus(); // TextField focusundan çık
                          },
                          controller: _adSoyadController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ad Soyad alanını doldurunuz.';
                            }
                            return null;
                          },
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
                        SizedBox(height: 0),
                        TextFormField(
                          onTap: () {
                            FocusScope.of(context).unfocus(); // TextField focusundan çık
                          },
                          cursorColor: Color(0xFFCF0000),
                          controller: _tcKimlikNoController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'TC Kimlik No alanını doldurunuz.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'TC Kimlik No',
                            hintText: '*Zorunlu Alan',
                            labelStyle: TextStyle(color: Color.fromARGB(255, 116, 113, 113) ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFFCF0000)), // Odaklandığında kullanılacak kenarlık rengi
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                        ),
                        SizedBox(height:0),
                        TextFormField(
                          onTap: () {
                            FocusScope.of(context).unfocus(); // TextField focusundan çık
                          },
                          cursorColor: Color(0xFFCF0000),
                          controller: _telefonController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Telefon Numarası alanını doldurunuz.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Telefon Numarası',
                            hintText: '*Zorunlu Alan',
                            labelStyle: TextStyle(color: Color.fromARGB(255, 116, 113, 113) ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFFCF0000)), // Odaklandığında kullanılacak kenarlık rengi
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                        ),
                        SizedBox(height: 0),
                        TextFormField(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          cursorColor: Color(0xFFCF0000),
                          controller: _adresController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Adres alanını doldurunuz.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Adres',
                            hintText: '*Zorunlu Alan',
                            labelStyle: TextStyle(color: Color.fromARGB(255, 116, 113, 113) ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFFCF0000)), // Odaklandığında kullanılacak kenarlık rengi
                            ),
                          ),
                        ),
                        SizedBox(height:0),
                        TextFormField(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          cursorColor: Color(0xFFCF0000),
                          controller: _mailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mail Adresi alanını doldurunuz.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Mail Adresi',
                            hintText: '*Zorunlu Alan',
                            labelStyle: TextStyle(color: Color.fromARGB(255, 116, 113, 113) ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFFCF0000)), // Odaklandığında kullanılacak kenarlık rengi
                            ),
                          ),
                        ),
                        SizedBox(height:0),
                        TextFormField(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          cursorColor: Color(0xFFCF0000),
                          controller: _bagislarController,
                          decoration: InputDecoration(
                            labelText: 'Bağışlarınız',
                            hintText: 'Aralarına virgül koyarak yazın.',
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
                              String adSoyad = _adSoyadController.text;
                              if (_formKey.currentState!.validate()) {
                                // Form geçerliyse gönderilecek işlemler burada yapılır
                                sendFormToFirebase();
                                sepetUrunSayisi2 = 0;
                                if ((cartItemsB == null || cartItemsB.isEmpty)) {

                                }else{
                                  sendToFirestore('tc_no', _tcKimlikNoController.text, cartItemsB, 'shop_cart_bagis');
                                }
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Sayın ' + adSoyad),
                                      content: Text('Kargo aracı en yakın zamanda adresinize gönderilecek.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => BagisListesi(),
                                              ),
                                            );
                                          },
                                          child: Text('Tamam'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // Form geçerli değilse hata mesajı gösterilir
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Hata'),
                                      content: Text('Zorunlu alanları doldurun.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Tamam'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFC85353),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: myFab(context),
      bottomNavigationBar: myBottomNaviBar(page, context),
    );
  }
}