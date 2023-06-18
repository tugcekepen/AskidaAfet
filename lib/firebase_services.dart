import 'package:cloud_firestore/cloud_firestore.dart';

mixin FirebaseService {
  FirebaseFirestore get firestoreInstance => FirebaseFirestore.instance;

  Future<void> sendFormData(Map<String, dynamic> formValues, String collectionName) async {
    try {
      final collectionRef = firestoreInstance.collection(collectionName); //firestore'da hangi collection'a döküman oluşturmak istiyorsan o metot parametresine o collecionName'i ver
      final newDocumentRef = collectionRef.doc(); // Yeni bir belge referansı oluşturulur
      await newDocumentRef.set(formValues);
      print('Form başarıyla Firestore\'a gönderildi');
    } catch (error) {
      print('Form gönderilirken hata oluştu: $error');
      rethrow;
    }
  }

  static Future<List<String>> getIhtiyacItems() async {
    final DocumentSnapshot itemListDoc =
    await FirebaseFirestore.instance.collection('itemList').doc('itemListI').get();
    final Map<String, dynamic>? itemListData = itemListDoc.data() as Map<String, dynamic>?;
    if (itemListData != null) {
      return itemListData.keys.toList();
    } else {
      return [];
    }
  }

  static Future<List<String>> getBagisItems() async {
    final DocumentSnapshot itemListDoc = await FirebaseFirestore.instance
        .collection('itemList')
        .doc('itemListB')
        .get();
    final Map<String, dynamic>? itemListData = itemListDoc.data() as Map<String, dynamic>?;
    if (itemListData != null && itemListData['items'] is List) {
      final List<dynamic> itemList = itemListData['items'] as List<dynamic>;
      return itemList.cast<String>();
    } else {
      return [];
    }
  }

  static Future<String> getAboutUsDesc(String docName) async {
    final DocumentSnapshot descriptionDoc = await FirebaseFirestore.instance
        .collection('fixed_texts')
        .doc(docName)
        .get();
    final Map<String, dynamic>? data = descriptionDoc.data() as Map<String, dynamic>?;
    final String? descrip = data?['description'] as String?;
    if(descrip != null && descrip.isNotEmpty){
      return descrip;
    } else {
      return "";
    }
  }

  static Future<void> addVolunteer(String email) async {
    await FirebaseFirestore.instance.collection('volunteers').add({
      'mail': email,
    });
  }
}