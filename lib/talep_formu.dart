import 'package:flutter/material.dart';
import 'package:askida_afet/shopping_cart_screen.dart';
import 'ihtiyac_listesi.dart';

bool kodOlusturuldu = false;

class TalepFormu extends StatefulWidget {
  @override
  _TalepFormuState createState() => _TalepFormuState();
}

class _TalepFormuState extends State<TalepFormu> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _adSoyadController = TextEditingController();
  TextEditingController _adresController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();

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
                        decoration: InputDecoration(
                          hintText: 'Aralarına virgül koyarak yazınız',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xFFCF0000))
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        cursorColor: Color(0xFFCF0000),
                        validator: (value) {
                          if ((value == null || value.isEmpty)) {
                            return 'Talep kodunuz yok ise taleplerinizi yazınız.\nTalep kodunuz var ise Talep Kodu başlığı altına yapıştırın.'; // Doğrulama hatası mesajı
                          }
                          return null; // Geçerli değer
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
                          return null; // Geçerli bir değer olduğunda null döndürülür
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
                            return 'Açık Adres alanını doldurunuz.'; // Ad Soyad alanı boş ise hata mesajı döndürülür
                          }
                          return null; // Geçerli bir değer olduğunda null döndürülür
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
                            return 'Mail Adresi alanını doldurunuz.'; // Ad Soyad alanı boş ise hata mesajı döndürülür
                          }
                          return null; // Geçerli bir değer olduğunda null döndürülür
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
                            return 'Telefon alanını doldurunuz.'; // Ad Soyad alanı boş ise hata mesajı döndürülür
                          }
                          return null; // Geçerli bir değer olduğunda null döndürülür
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
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form geçerliyse gönderilecek işlemler burada yapılır
                          final snackBar = SnackBar(content: Text('Form başarıyla gönderildi'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      ),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC85353),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
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
