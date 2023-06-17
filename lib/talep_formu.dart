import 'package:askida_afet/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:askida_afet/shopping_cart_screen.dart';
import 'ihtiyac_listesi.dart';


bool kodOlusturuldu = false;
TextEditingController _taleplerController = TextEditingController();
TextEditingController _adSoyadController = TextEditingController();
TextEditingController _adresController = TextEditingController();
TextEditingController _mailController = TextEditingController();
TextEditingController _telefonController = TextEditingController();

class TalepFormu extends StatefulWidget{
  @override
  _TalepFormuState createState() => _TalepFormuState();
}

class _TalepFormuState extends State<TalepFormu> with FirebaseService {
  final _formKey = GlobalKey<FormState>();

  void sendFormToFirebase() {
    String girdi = _taleplerController.text;
    List<String> talepler = girdi.split(',');
    talepler = talepler.map((talep) => talep.trim()).toList();

    final formValues = {
      'talep_kodu': requestCode,
      'talepler': talepler,
      'ad_soyad': _adSoyadController.text,
      'adres': _adresController.text,
      'mail': _mailController.text,
      'telefon': _telefonController.text,
    };

    sendFormData(formValues, 'talep_forms')
        .then((_) {
      // Gönderme işlemi başarılı olduğunda yapılacak işlemler
      cartItems = {};
      requestCode = "";
      _taleplerController.text = "";
      _adSoyadController.text = "";
      _adresController.text = "";
      _mailController.text= "";
      _telefonController.text = "";
      final snackBar = SnackBar(content: Text('Form başarıyla gönderildi'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IhtiyacListesi(),
        ),
      );
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
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  'Talep Formu',
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
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'İhtiyaç Listesinde bulamadığınız ürünleri "Talepler" başlığı altına ve aralarına virgül koyarak yazınız.',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Talep Kodu (Sepette oluşturuldu ise)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Kopyalanan kodu BURAYA YAPIŞTIRINIZ',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFFCF0000))
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        initialValue: kodOlusturuldu ? requestCode : null,
                        cursorColor: Color(0xFFCF0000),
                        keyboardType: TextInputType.number,
                        maxLength: 7,
                      ),
                    ),
                    SizedBox(height: 0),
                    Text(
                      'Talepler',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _taleplerController,
                        decoration: InputDecoration(
                          hintText: 'Aralarına virgül koyarak yazınız',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFFCF0000))
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        cursorColor: Color(0xFFCF0000),
                        validator: (value) {
                          if ((requestCode == null || requestCode.isEmpty)) {
                            if (value == null || value.isEmpty) {
                              return 'Talep kodunuz yok ise taleplerinizi yazınız.\nTalep kodunuz var ise Talep Kodu başlığı altına yapıştırın.';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ad Soyad',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _adSoyadController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ad Soyad alanını doldurunuz.'; // Ad Soyad alanı boş ise hata mesajı döndürülür
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '*Zorunlu Alan',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFFCF0000))
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        cursorColor: Color(0xFFCF0000),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Açık Adres',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _adresController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Açık Adres alanını doldurunuz.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '*Zorunlu Alan',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFFCF0000))
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        cursorColor: Color(0xFFCF0000),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Mail Adresi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _mailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mail Adresi alanını doldurunuz.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '*Zorunlu Alan',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFFCF0000))
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        cursorColor: Color(0xFFCF0000),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Telefon',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _telefonController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Telefon alanını doldurunuz.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '*Zorunlu Alan',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFFCF0000))
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        cursorColor: Color(0xFFCF0000),
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                      ),
                    ),
                    SizedBox(height: 0),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Form geçerliyse gönderilecek işlemler burada yapılır
                            sendFormToFirebase();
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
                        child: Text('Gönder',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC85353),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 65), // boşluk değeri
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/liveSupport');
            // Chatbot ikonuna tıklandığında yapılacak işlemler
          },
          backgroundColor: Color(0xFFCF0000),
          child: const Icon(
            Icons.support_agent_outlined,
            color: Colors.white,
            size: 45,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Colors.black,
            ),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.help_outline_outlined,
              size: 30,
              color: Colors.black,
            ),
            label: 'Talep Formu',
          ),
        ],
        currentIndex: 1,
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
