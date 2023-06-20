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

  static Future<Map<String, dynamic>> getAllStores() async {
    final CollectionReference _storesCollection = FirebaseFirestore.instance
        .collection('stores');
    try {
      DocumentSnapshot snapshot = await _storesCollection.doc('all-stores').get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      print('Hata: $e');
      return {};
    }
  }

  static Future<void> addMailInTheDrawer(String collectionName, String email) async {
    await FirebaseFirestore.instance.collection(collectionName).add({
      'mail': email,
    });
  }

  void sendToFirestore(String id, String code, Map<String, int> items, String collectionName) {
    DocumentReference docRef = firestoreInstance.collection(collectionName).doc();

    // Belgeye eklenecek anahtar ve değerleri oluşturma
    Map<String, dynamic> documentData = {
      id: code,
    };

    // Item'ları belgeye ekleyin
    items.forEach((item, count) {
      documentData[item] = count;
    });

    // Belgeyi Firestore koleksiyonuna ekleyin
    docRef.set(documentData)
        .then((value) => print('Belge Firestore\'a başarıyla eklendi!'))
        .catchError((error) => print('Belge eklenirken bir hata oluştu: $error'));
  }
}