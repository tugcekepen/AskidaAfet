import 'package:askida_afet/bagis_formu.dart';
import 'package:askida_afet/bagis_listesi.dart';
import 'package:askida_afet/login_screen.dart';
import 'package:askida_afet/main.dart';
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
      if (page == 0) {
        if (cartItems.containsKey(item)) {
          int itemCount = cartItems[item]!;
          cartItems.remove(item);
          sepetUrunSayisi -= itemCount;
        }
      } else if (page == 1) {
        if (cartItemsB.containsKey(item)) {
          int itemCount = cartItemsB[item]!;
          cartItemsB.remove(item);
          sepetUrunSayisi2 -= itemCount;
        }
      }
    });
  }

  void increaseItemCount(String item) {
    setState(() {
      if (page == 0) {
        sepetUrunSayisi++;
        if (cartItems.containsKey(item)) {
          cartItems[item] = cartItems[item]! + 1;
        } else {
          cartItems[item] = 1;
        }
      } else if (page == 1) {
        sepetUrunSayisi2++;
        if (cartItemsB.containsKey(item)) {
          cartItemsB[item] = cartItemsB[item]! + 1;
        } else {
          cartItemsB[item] = 1;
        }
      }
    });
  }

  void decreaseItemCount(String item) {
    setState(() {
      if (page == 0) {
        sepetUrunSayisi--;
        if (cartItems.containsKey(item)) {
          if (cartItems[item]! > 1) {
            cartItems[item] = cartItems[item]! - 1;
          } else {
            cartItems.remove(item);
          }
        }
      } else if (page == 1) {
        sepetUrunSayisi2--;
        if (cartItemsB.containsKey(item)) {
          if (cartItemsB[item]! > 1) {
            cartItemsB[item] = cartItemsB[item]! - 1;
          } else {
            cartItemsB.remove(item);
          }
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
            if (page == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IhtiyacListesi(),
                ),
              );
            } else if (page == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BagisListesi(),
                ),
              );
            }
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              page == 0 ? 'İhtiyaç Sepeti' : 'Bağış Sepeti',
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
          if (page == 0)
            if (cartItems.isEmpty) ShopCartEmptyContainer(page: page),
          if (page == 1)
            if (cartItemsB.isEmpty) ShopCartEmptyContainer(page: page),
          Expanded(
            child: Container(
              color: Color(0xFFF4F4F4),
              padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: ListView.builder(
                itemCount: page == 0 ? cartItems.length : cartItemsB.length,
                itemBuilder: (context, index) {
                  if (page == 0) {
                    final item = cartItems.keys.elementAt(index);
                    final count = cartItems[item];
                    return ShopCartContainer(
                      item: item,
                      count: count!,
                      decreaseItemCount: decreaseItemCount,
                      increaseItemCount: increaseItemCount,
                      removeItem: removeItem,
                    );
                  } else if (page == 1) {
                    final item = cartItemsB.keys.elementAt(index);
                    final count = cartItemsB[item];
                    return ShopCartContainer(
                      item: item,
                      count: count!,
                      decreaseItemCount: decreaseItemCount,
                      increaseItemCount: increaseItemCount,
                      removeItem: removeItem,
                    );
                  }

                  return Container();
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              page == 0
                  ? 'Talep Kodu oluşturduktan sonra kodu kopyalayıp "Talep Formu" sayfasındaki formda "Talep Kodu" başlığı altına yapıştırınız.\n\nİhtiyaç Listesinde bulamadığınız ürünleri "Talep" sayfasındaki formu doldururken "Talepler" başlığı altına ve aralarına virgül koyarak yazınız.\n\nÖNEMLİ!'
                  : 'Bağışlamak isteyip de Bağış İhtiyaç Listesinde bulamadığınız ürünleri "Bağış Formu" sayfasındaki formu doldururken "Bağışlar" başlığı altına ve aralarına virgül koyarak yazınız.\n\nÖNEMLİ!',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF0E194D),
              ),
            ),
          ),
          if (page == 0)
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
          if (page == 1)
            if (cartItemsB.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BagisFormu()),
                      );
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

class ShopCartContainer extends StatelessWidget {
  final String item;
  final int count;
  final Function(String) decreaseItemCount;
  final Function(String) increaseItemCount;
  final Function(String) removeItem;

  ShopCartContainer({
    required this.item,
    required this.count,
    required this.decreaseItemCount,
    required this.increaseItemCount,
    required this.removeItem,
  });

  @override
  Widget build(BuildContext context) {
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
  }
}

class ShopCartEmptyContainer extends StatelessWidget {
  final int page;

  ShopCartEmptyContainer({required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                if (page == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IhtiyacListesi(),
                    ),
                  );
                } else if (page == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BagisListesi(),
                    ),
                  );
                }
              },
              child: Text(page == 0
                  ? 'İhtiyaç Listesine Git'
                  : 'Bağış İhtiyaç Listesine Git'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC85353),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (page == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TalepFormu(),
                    ),
                  );
                } else if (page == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BagisFormu(),
                    ),
                  );
                }
              },
              child:
                  Text(page == 0 ? 'Talep Formuna Git' : 'Bağış Formuna Git'),
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
      color: Color(0xFFF4F4F4),
    );
  }
}

Map<String, int> cartItems = {}; // Sepet öğeleri ve adetleri
Map<String, int> cartItemsB = {}; // Sepet öğeleri ve adetleri
