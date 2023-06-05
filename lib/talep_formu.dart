import 'package:flutter/material.dart';

class TalepFormu extends StatelessWidget {
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
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Kopyalanan kodu BURAYA YAPIŞTIRINIZ',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 7,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Talepler',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Aralarına virgül koyarak yazınız',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
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
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: '*Zorunlu Alan',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
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
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: '*Zorunlu Alan',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
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
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: '*Zorunlu Alan',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
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
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: '*Zorunlu Alan',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
