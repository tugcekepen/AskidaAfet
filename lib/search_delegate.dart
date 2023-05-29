import 'package:flutter/material.dart';
import 'package:askida_afet/ihtiyac_listesi.dart';
import 'package:askida_afet/shopping_cart_screen.dart';

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
    // Arama sonuçlarını burada gösterin (isteğe bağlı)
    final List<String> searchResults = itemList
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
            selectedItems.add(result);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShoppingCartScreen(), // Sepet ekranını aç
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Arama önerilerini burada gösterin (isteğe bağlı)
    return Container();
  }
}
