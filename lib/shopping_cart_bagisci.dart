import 'package:askida_afet/bagis_listesi.dart';
import 'package:askida_afet/bagis_formu.dart';
import 'package:askida_afet/main.dart';
import 'package:flutter/material.dart';
import 'package:askida_afet/ihtiyac_listesi.dart';
import 'package:flutter/services.dart';

class BagisciShopping extends StatefulWidget {
  @override
  _BagisciShoppingState createState() => _BagisciShoppingState();
}

class _BagisciShoppingState extends State<BagisciShopping> {
  IhtiyacListesi iList = new IhtiyacListesi();
  String requestCode = ''; // Talep Kodu

  void removeItem(String item) {
    setState(() {
      if (cartItemsB.containsKey(item)) {
        int itemCount = cartItemsB[item]!;
        cartItemsB.remove(item);
        sepetUrunSayisi2 -= itemCount;
      }
    });
  }

  void increaseItemCount(String item) {
    setState(() {
      sepetUrunSayisi2++;
      if (cartItemsB.containsKey(item)) {
        cartItemsB[item] = cartItemsB[item]! + 1;
      } else {
        cartItemsB[item] = 1;
      }
    });
  }

  void decreaseItemCount(String item) {
    setState(() {
      sepetUrunSayisi2--;
      if (cartItemsB.containsKey(item)) {
        if (cartItemsB[item]! > 1) {
          cartItemsB[item] = cartItemsB[item]! - 1;
        } else {
          cartItemsB.remove(item);
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
                builder: (context) => BagisListesi(),
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
              'Bağış Sepeti',
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
          if (cartItemsB.isEmpty)
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
                            builder: (context) => BagisListesi(),
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
                            builder: (context) => BagisFormu(),
                          ),
                        );
                      },
                      child: Text('Bağış Formuna Git'),
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
              padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: ListView.builder(
                itemCount: cartItemsB.length,
                itemBuilder: (context, index) {
                  final item = cartItemsB.keys.elementAt(index);
                  final count = cartItemsB[item];
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
                            size: 30,
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
              'Bağışlamak isteyip de Bağış İhtiyaç Listesinde bulamadığınız ürünleri "Bağış Formu" sayfasındaki formu doldururken "Bağışlar" başlığı altına ve aralarına virgül koyarak yazınız.\n\nÖNEMLİ!',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF0E194D),
              ),
            ),
          ),
          if (cartItemsB.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BagisFormu()),);
                  },
                  icon: Icon(Icons.send_outlined),
                  label: Text(
                    'Yardım Et',
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
      floatingActionButton: myFab(context),
    );
  }
}

Map<String, int> cartItemsB = {}; // Sepet öğeleri ve adetleri