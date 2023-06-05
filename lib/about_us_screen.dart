import 'package:askida_afet/ihtiyac_listesi.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hakkımızda'),
        backgroundColor: Color(0xFF962929),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '''Askıda Afet uygulaması, afet durumlarında ortaya çıkan ihtiyaçları hızlı ve etkin bir şekilde çözmeyi hedeflemektedir. İhtiyaç ambarı ve talep sistemi sayesinde afetzedelerin ihtiyaçlarını tespit eder ve organize eder.
                
Yardım kaynaklarının etkin bir şekilde kullanılması sağlanırken iletişim ve koordinasyon da kolaylaştırılmaktadır. Uygulama, yardımların herkes arasında adil bir şekilde dağıtılmasını sağlayan adaletli ve eşit dağıtım ilkesine dayanmaktadır.

Bu şekilde toplumun birlikte hareket etmesini ve afetlerle mücadelede birbirine destek olmasını sağlayarak güçlü bir toplumsal dayanışma ağı oluşturmayı amaçlıyoruz.''',
                style: TextStyle(fontSize: 16.8, color: Colors.black),
              ),
              SizedBox(height: 15),
              Center(
                child: Card(
                  color: Color(0xFFEDEDED),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ekibimize Katıl',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 13),
                        Text('Mail Adresin:'),
                        SizedBox(height: 8),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'ornek@gmail.com',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))),

                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Geri dönüş işlemleri
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Teşekkürler!"),
                                    content: Text('Mail adresin ekiplere iletildi. En yakın zamanda geri dönüş alacaksın.'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => IhtiyacListesi()),
                                          );
                                        },
                                        child: Text('Tamam'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFC85353),
                                          padding: EdgeInsets.symmetric(vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFC85353),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            child: Text('Geri Dönüş Yapalım'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
