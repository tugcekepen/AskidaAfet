import 'package:askida_afet/bagis_formu.dart';
import 'package:askida_afet/bagis_listesi.dart';
import 'package:askida_afet/ihtiyac_listesi.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:askida_afet/logo_screen.dart';
import 'package:askida_afet/login_screen.dart';
import 'package:askida_afet/live_support_page.dart';
import 'package:askida_afet/talep_formu.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: SplashScreen(), // Başlangıç ekranı olarak SplashScreen'i kullanıyoruz
          debugShowCheckedModeBanner: false,
          routes: {
            '/loginScreen': (context) => LoginScreen(),
            '/liveSupport': (context) => LiveSupportPage(),
          },
        );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/loginScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LogoScreen(), // Başlangıç ekranı olarak LogoScreen'i kullanıyoruz
    );
  }
}

Widget myFab(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: 65),
    child: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LiveSupportPage()),
        );
        // Chatbot ikonuna tıklandığında yapılacak işlemler
      },
      backgroundColor: Color(0xFFCF0000),
      child: const Icon(
        Icons.support_agent_outlined,
        color: Colors.white,
        size: 45,
      ),
    ),
  );
}

Widget myBottomNaviBar(int currentPage, BuildContext context) {
  return BottomNavigationBar(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
    unselectedItemColor: Colors.black,
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
    items: [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          size: 30,
        ),
        label: 'Ana Sayfa',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.help_outline_outlined,
          size: 30,
        ),
        label: currentPage == 0 ? 'Talep Formu' : 'Bağış Formu',
      ),
    ],
    onTap: (index) {
      if (currentPage == 0) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IhtiyacListesi()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TalepFormu()),
            );
            break;
        }
      } else if (currentPage == 1) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BagisListesi()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BagisFormu()),
            );
            break;
        }
      }
    },
  );
}

void commandLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    print('could not launch $command');
  }
}

