import 'package:askida_afet/talep_formu.dart';
import 'package:flutter/material.dart';
import 'package:askida_afet/ihtiyac_listesi.dart';
import 'package:flutter/services.dart';
import 'dart:math';

String generateRandomCode() {
  Random random = Random();
  return random.nextInt((9000000) + 1000000).toString();
}

String requestCode = ''; // Talep Kodu

class IhtiyacShopping extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<IhtiyacShopping> {
  IhtiyacListesi iList = new IhtiyacListesi();


  void generateRequestCode() {
    setState(() {
      requestCode = generateRandomCode();
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(requestCode),
          content: Text('Talep kodu kopyalandı'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: requestCode));
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TalepFormu()),
                );
              },
              child: Text('Tamam'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC85353),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  void removeItem(String item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  void increaseItemCount(String item) {
    setState(() {
      if (cartItems.containsKey(item)) {
        cartItems[item] = cartItems[item]! + 1;
      } else {
        cartItems[item] = 1;
      }
    });
  }

  void decreaseItemCount(String item) {
    setState(() {
      if (cartItems.containsKey(item)) {
        if (cartItems[item]! > 1) {
          cartItems[item] = cartItems[item]! - 1;
        } else {
          cartItems.remove(item);
        }
      }
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
              MaterialPageRoute(
                builder: (context) => IhtiyacListesi(),
              ),
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'İhtiyaç Sepeti',
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
          if (cartItems.isEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Sepetinizde ürün bulunmamaktadır.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IhtiyacListesi(),
                          ),
                        );
                      },
                      child: Text('İhtiyaç Listesine Git'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC85353),
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TalepFormu(),
                          ),
                        );
                      },
                      child: Text('Talep Formuna Git'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC85353),
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              color: Color(0xFFF4F4F4),
            ),
          Expanded(
            child: Container(
              color: Color(0xFFF4F4F4),
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems.keys.elementAt(index);
                  final count = cartItems[item];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            decreaseItemCount(item);
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Color(0xFFCF0000),
                            size: 35,
                          ),
                        ),
                        Text(
                          '$count',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            increaseItemCount(item);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Color(0xFFCF0000),
                            size: 35,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            removeItem(item);
                          },
                          icon: Icon(
                            Icons.delete_outline_outlined,
                            color: Color(0xFFCF0000),
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Talep Kodu oluşturduktan sonra kodu kopyalayıp "Talep Formu" sayfasındaki formda "Talep Kodu" başlığı altına yapıştırınız.\n\nİhtiyaç Listesinde bulamadığınız ürünleri "Talep" sayfasındaki formu doldururken "Talepler" başlığı altına ve aralarına virgül koyarak yazınız.\n\nÖNEMLİ!',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF0E194D),
              ),
            ),
          ),
          if (cartItems.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    kodOlusturuldu = true;
                    generateRequestCode();
                  },
                  icon: Icon(Icons.copy),
                  label: Text(
                    'Talep Kodu Oluştur',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC85353),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 65),
        child: FloatingActionButton(
          onPressed: () {
            // Chatbot ikonuna tıklandığında yapılacak işlemler
            Navigator.pushNamed(context, '/liveSupport');
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

Map<String, int> cartItems = {}; // Sepet öğeleri ve adetleri