import 'package:askida_afet/shopping_cart_ihtiyac.dart';
import 'package:askida_afet/talep_formu.dart';
import 'package:flutter/material.dart';
import 'package:askida_afet/drawer_menu.dart';
import 'package:askida_afet/search_delegate.dart';
import 'package:askida_afet/live_support_page.dart';
import 'package:askida_afet/firebase_services.dart';

List<String> itemListI = [];

class IhtiyacListesi extends StatefulWidget {
  @override
  _IhtiyacListesiState createState() => _IhtiyacListesiState();
}

class _IhtiyacListesiState extends State<IhtiyacListesi> with FirebaseService{
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    searchText = '';
    getItems();
  }

  //firestore'dan çekilen veriler, arayüzlerde kullanabilsin diye kod içerisinde tanımlanmış listelere atanıyor
  Future<void> getItems() async {
    List<String> items = await FirebaseService.getIhtiyacItems();
    setState(() {
      itemListI = items;
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
                MaterialPageRoute(builder: (context) => IhtiyacShopping()),
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
        future: FirebaseService.getIhtiyacItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<String> itemListI = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'İhtiyaç Listesi',
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
                      itemCount: itemListI.length,
                      itemBuilder: (context, index) {
                        final item = itemListI[index];
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
                                  // İkon tıklama işlemleri
                                  if (cartItems.containsKey(item)) {
                                    cartItems[item] = cartItems[item]! + 1;
                                  } else {
                                    cartItems[item] = 1;
                                  }
                                  final snackBar = SnackBar(
                                    duration: const Duration(milliseconds: 800),
                                    content: Text('Sepetinize ürün eklendi'),
                                    action: SnackBarAction(
                                      label: 'Geri Al',
                                      onPressed: () {
                                        if (cartItems.containsKey(item)) {
                                          if (cartItems[item]! > 1) {
                                            cartItems[item] = cartItems[item]! - 1;
                                          } else {
                                            cartItems.remove(item);
                                          }
                                        }
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
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
            return Center(
              child: Text('Veriler alınırken bir hata oluştu.'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
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
      drawer: DrawerMenu(),
    );
  }
}


