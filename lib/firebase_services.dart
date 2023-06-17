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
}





/*

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
*/