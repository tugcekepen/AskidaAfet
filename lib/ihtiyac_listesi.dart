import 'package:askida_afet/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:askida_afet/drawer_menu.dart';
import 'package:askida_afet/search_delegate.dart';

/*void copyItemsToCart() {
  cartItems.clear();
  for (int i = 0; i < selectedItems.length; i++) {
    String item = selectedItems[i];
    if (selectedItems.contains(item)) {
      cartItems[item] = (cartItems[item] ?? 0) + 1;
    } else {
      cartItems[item] = 1;
    }
  }
}*/

class IhtiyacListesi extends StatefulWidget {
  @override
  _IhtiyacListesiState createState() => _IhtiyacListesiState();

}

class _IhtiyacListesiState extends State<IhtiyacListesi> {
  int _currentIndex = 0;
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    searchText = '';
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
          tooltip: 'Menüyü Aç',
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
                MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
              );
            },
            tooltip: 'Sepete Git'
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
            tooltip: 'Arama Yap'
          ),
        ],
      ),
      body: Column(
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
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  final item = itemList[index];
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 65), // boşluk değeri
        child: FloatingActionButton(
          onPressed: () {
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
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
            label: 'Talep',
          ),
        ],
      ),
      drawer: DrawerMenu(),
    );
  }
}

List<String> itemList = [
  'Battaniye',
  'Bebek Maması',
  'Büyük-Küçük Tüp',
  'Cep Isıtıcısı',
  'Çadır',
  'Çocuk-Yetişkin Bezi',
  'Çocuk-Yetişkin İç Giyim',
  'Çocuk-Yetişkin Mont',
  'Elektrikli Isıtıcı',
  'Hijyen Kolisi',
  'Jeneratör',
  'Kadın-Erkek Ayakkabı',
  'Kadın-Erkek İç Giyim ve Çorap',
  'Odun, Kömür Sobası-Odun',
  'Powerbank',
  'Su-Ekmek-Hazır Gıda',
  'Uyku Tulumu-Yastık',
  'Yatak ve Nevresim Takımı',
];

