import 'package:askida_afet/contact_screen.dart';
import 'package:askida_afet/login_screen.dart';
import 'package:askida_afet/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:askida_afet/about_us_screen.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.white, // Header'ın arka plan rengini ayarlayabilirsiniz
            child: Image.asset(
              'assets/images/logo.jpg',
              fit: BoxFit.fill,
            ),
          ),
          ListTile(
            leading: Icon(Icons.info,
            size: 30,
            color: Color(0xFF3B3B3B)),
            title: Text('Hakkımızda'),
            onTap: () {
              // Hakkımızda seçeneğine tıklama işlemleri
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.mail,
              size: 30,
              color: Color(0xFF3B3B3B)),
            title: Text('İletişim'),
            onTap: () {
              // İletişim seçeneğine tıklama işlemleri
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings_rounded,
              size: 30,
              color: Color(0xFF3B3B3B),
            ),
            title: Text('Ayarlar'),
            onTap: () {
              // Ayarlar seçeneğine tıklama işlemleri
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new_outlined,
              size: 30,
              color: Color(0xFF3B3B3B)),
            title: Text('Çıkış'),
            onTap: () {
              // Çıkış seçeneğine tıklama işlemleri
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
