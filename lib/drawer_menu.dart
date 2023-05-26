import 'package:flutter/material.dart';

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
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_outlined,
              size: 30,
              color: Color(0xFF3B3B3B)),
            title: Text('Çıkış'),
            onTap: () {
              // Çıkış seçeneğine tıklama işlemleri
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
