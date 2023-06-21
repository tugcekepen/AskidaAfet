import 'package:flutter/material.dart';
import 'package:askida_afet/ihtiyac_listesi.dart';
import 'package:askida_afet/shopping_cart_ihtiyac.dart';
import 'package:askida_afet/login_screen.dart';
import 'package:askida_afet/bagis_listesi.dart';

class Search_Delegate extends SearchDelegate<String> {
  IhtiyacListesi ihtiyacListesi; // IhtiyacListesi sınıfına referans
  Search_Delegate(this.ihtiyacListesi); // Constructor

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new_outlined),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //arama sonuçları, uygulamadaki profile göre düzenleniyor
    // page=0 -> İhtiyaç Sahibi
    // page=1 -> Bağışçı
    if (page == 0) {
      final List<String> searchResults = itemListI
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final result = searchResults[index];
          return ListTile(
            title: Text(result),
            onTap: () {
              // Sonuç seçildiğinde yapılacak işlemler
              if (page == 0) {
                sepetUrunSayisi++;
                if (cartItems.containsKey(result)) {
                  cartItems[result] = cartItems[result]! + 1;
                } else {
                  cartItems[result] = 1;
                }
              } else if (page == 1) {
                sepetUrunSayisi2++;
                if (cartItemsB.containsKey(result)) {
                  cartItemsB[result] = cartItemsB[result]! + 1;
                } else {
                  cartItemsB[result] = 1;
                }
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IhtiyacShopping(),
                ),
              );
            },
          );
        },
      );
    } else if (page == 1) {
      final List<String> searchResults = itemListB
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final result = searchResults[index];
          return ListTile(
            title: Text(result),
            onTap: () {
              // Sonuç seçildiğinde yapılacak işlemler
              if (page == 0) {
                sepetUrunSayisi++;
                if (cartItems.containsKey(result)) {
                  cartItems[result] = cartItems[result]! + 1;
                } else {
                  cartItems[result] = 1;
                }
              } else if (page == 1) {
                sepetUrunSayisi2++;
                if (cartItemsB.containsKey(result)) {
                  cartItemsB[result] = cartItemsB[result]! + 1;
                } else {
                  cartItemsB[result] = 1;
                }
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IhtiyacShopping(),
                ),
              );
            },
          );
        },
      );
    } else {
      // Eğer hiçbir şarta uymuyorsa boş bir Container döndürerek hata durumunu engelleyebiliriz.
      return Container();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Arama önerileri (isteğe bağlı)
    return Container();
  }
}
