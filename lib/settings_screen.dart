import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:askida_afet/firebase_services.dart';
import 'package:askida_afet/location_services.dart';
import 'package:askida_afet/login_screen.dart';
import 'package:askida_afet/main.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkModeEnabled = false;
  bool _isNotification = true;
  TextEditingController _emailController = TextEditingController();
  Location location = Location();
  LocationData? currentLocation; // Konum verisini tutmak için nullable değişken
  Completer<GoogleMapController> haritaControl = Completer();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    checkLocationPermission(); // Konum iznini kontrol et
  }

  Future<void> getCurrentLocation() async {
    LocationData? locationData = await LocationService.getCurrentLocation();
    setState(() {
      currentLocation = locationData;
    });
    if (locationData != null) {
      final GoogleMapController controller = await haritaControl.future;
      controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!),
        ),
      );
    }
  }

  Future<void> checkLocationPermission() async {
    bool hasPermission = await LocationService.checkLocationPermission();
    if (!hasPermission) {
      bool granted = await LocationService.requestLocationPermission();
      if (granted) {
        await getCurrentLocation();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
        backgroundColor: Color(0xFF962929),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white, // Geri butonunun rengi
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(children: [
        SizedBox(height: MediaQuery.of(context).size.height/80),
        // Bu switch çalışmıyor !!!!!!!!!!!!!!!!!!!
        ListTile(
          leading: Icon(Icons.dark_mode),
          title: Text('Dark Mod'),
          trailing: Switch(
            value: _isDarkModeEnabled,
            onChanged: (value) {
              _isDarkModeEnabled = value;
            },
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/150),
        // Bu switch çalışmıyor !!!!!!!!!!!!!!!!!!!
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Bildirimler'),
          trailing: Switch(
            value: _isNotification,
            onChanged: (value) {
              setState(() {
                _isNotification = value;
              });
              if (_isNotification) {

              }

            },
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/150),
        ListTile(
          leading: Icon(Icons.location_on,),
          title: Text('Konum'),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/150),
        if(page==0)
          ...[
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Konumunuzu, size daha iyi hizmet verebilmek için alıyoruz. Yoğun noktalara daha fazla ihtiyaç ambarı ve stok sağlayabilmemiz ve sizlerin daha etkin yardım hizmeti alabilmesi bizim için önemli.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          ],
        if(page==1)
          ...[
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Konumunuzu, size daha iyi hizmet verebilmek için alıyoruz. Yoğun şekilde bağış gelen noktaları saptayabilmek, ihtiyaç ambarı depolarımızın konumunu etkileyen önemli bir faktör.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        SizedBox(height: MediaQuery.of(context).size.height/50),
        Container(
          height: 300,
          width: 400,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: currentLocation != null
                ? CameraPosition(
              target: LatLng(
                currentLocation!.latitude!,
                currentLocation!.longitude!,
              ),
              zoom: 150,
            )
                : CameraPosition(
              target: LatLng(0, 0),
              zoom: 5,
            ),
            onMapCreated: (GoogleMapController controller) {
              haritaControl.complete(controller);
            },
            markers: currentLocation != null
                ? Set<Marker>.of([
              Marker(
                markerId: MarkerId('currentLocation'),
                position: LatLng(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                ),
                infoWindow: InfoWindow(title: 'Konumunuz'),
              ),
            ])
                : Set<Marker>(),
            myLocationEnabled: true,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/150),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          'Konumunuzu yanlış alıyorsak lütfen bize bildiriniz.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/50),
                        Text('Mail Adresin:'),
                        SizedBox(height: MediaQuery.of(context).size.height/80),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'ornek@gmail.com',
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Color(0xFFCF0000))),
                          ),
                          cursorColor: Color(0xFFCF0000),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/50),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              // Geri dönüş işlemleri
                              await FirebaseService.addMailInTheDrawer(
                                  'false_locations', _emailController.text);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Teşekkürler!"),
                                    content: Text(
                                        'Mail adresin ekiplere iletildi. En yakın zamanda iyileştirmemizi yapacağız.'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Tamam'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFC85353),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              _emailController.text = "";
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFC85353),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            child: Text('Konumum Yanlış'),
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
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: myFab(context),
    );
  }
}
