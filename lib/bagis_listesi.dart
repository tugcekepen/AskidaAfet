import 'package:askida_afet/drawer_menu.dart';
import 'package:askida_afet/firebase_services.dart';
import 'package:askida_afet/ihtiyac_listesi.dart';
import 'package:askida_afet/live_support_page.dart';
import 'package:askida_afet/search_delegate.dart';
import 'package:askida_afet/shopping_cart_bagisci.dart';
import 'package:flutter/material.dart';
import 'bagis_formu.dart';

List<String> itemListB = [];

class BagisListesi extends StatefulWidget {
  @override
  _BagisciKimligiState createState() => _BagisciKimligiState();
}

class _BagisciKimligiState extends State<BagisListesi> with FirebaseService{
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    searchText = '';
    getItems();
  }

  //firestore'dan çekilen veriler, arayüzlerde kullanabilsin diye kod içerisinde tanımlanmış listeye atanıyor
  Future<void> getItems() async {
    List<String> items = await FirebaseService.getBagisItems();
    setState(() {
      itemListB = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.menu, // Menü ikonu
            color: Color(0xFF3B3B3B),
            size: 30,
          ),
          onPressed: () {
            _scaffold.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        title: Text(
          'ASKIDA AFET',
          style: TextStyle(
            color: Color(0xFF3B3B3B),
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined, // Sağdaki ilk ikon
                color: Color(0xFF3B3B3B),
                size: 30,
              ),
              onPressed: () {
                // İkon tıklama işlemleri
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BagisciShopping()),
                );
              },
          ),
          IconButton(
              icon: Icon(
                Icons.search, // Sağdaki ikinci ikon
                color: Color(0xFF3B3B3B),
                size: 30,
              ),
              onPressed: () {
                // İkon tıklama işlemleri
                showSearch(context: context, delegate: Search_Delegate(IhtiyacListesi()));
              },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: FirebaseService.getBagisItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<String> itemListB = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Bağış İhtiyaç Listesi',
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
                Expanded(
                  child: Container(
                    color: Color(0xFFF4F4F4),
                    padding: EdgeInsets.all(16),
                    child: ListView.builder(
                      itemCount: itemListB.length,
                      itemBuilder: (context, index) {
                        final item = itemListB[index];
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
                                    color: Color(0xFFCF0000),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  final snackBar = SnackBar(
                                    duration: const Duration(milliseconds: 800),
                                    content: Text('Göndermek istediğiniz ürün eklendi'),
                                    action: SnackBarAction(
                                      label: 'Geri Al',
                                      onPressed: () {
                                        if (cartItemsB.containsKey(item)) {
                                          if (cartItemsB[item]! > 1) {
                                            cartItemsB[item] = cartItemsB[item]! - 1;
                                          } else {
                                            cartItemsB.remove(item);
                                          }
                                        }
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  // İkon tıklama işlemleri
                                  if (cartItemsB.containsKey(item)) {
                                    cartItemsB[item] = cartItemsB[item]! + 1;
                                  } else {
                                    cartItemsB[item] = 1;
                                  }
                                },
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Color(0xFFCF0000),
                                  size: 35,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Veriler alınamadı.');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 65),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LiveSupportPage()),);
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
        backgroundColor: Colors.white,
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
            label: 'Bağış Formu',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BagisListesi())
              );
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BagisFormu())
              );
              break;
          }
        },

      ),
      drawer: DrawerMenu(),
    );
  }
}