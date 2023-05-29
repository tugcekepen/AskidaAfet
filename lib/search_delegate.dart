import 'package:flutter/material.dart';
import 'package:askida_afet/ihtiyac_listesi.dart';

class Search_Delegate extends SearchDelegate<String> {
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
      icon: Icon(Icons.arrow_back),
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
            close(context, result);
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
