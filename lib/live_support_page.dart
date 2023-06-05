import 'package:askida_afet/ihtiyac_listesi.dart';
import 'package:askida_afet/talep_formu.dart';
import 'package:flutter/material.dart';

class LiveSupportPage extends StatefulWidget {
  @override
  _LiveSupportPageState createState() => _LiveSupportPageState();
}

class _LiveSupportPageState extends State<LiveSupportPage> {
  List<Message> messages = [];
  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 173, 169, 169),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Canlı Destek', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF962929),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 173, 169, 169),
              child: ListView.builder(
                reverse: true, // Mesajları ters sıralamak için reverse özelliğini true yapar
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  Message message = messages[index];
                  bool isUserMessage = message.isUserMessage;

                  return Align(
                    alignment: isUserMessage ? Alignment.topRight : Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Color.fromARGB(255, 194, 59, 59) : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        message.content,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chatController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Color(0xFF962929)),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Mesajınızı buraya yazın...',
                    ),
                    cursorColor: Color(0xFF962929),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.black),
                  onPressed: () {
                    String messageContent = chatController.text;
                    sendMessage(messageContent);
                    chatController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'Talep Formu',
          ),
        ],
        onTap: (index) {
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
        },
      ),
    );
  }

  void sendMessage(String content) {
    setState(() {
      messages.insert(0, Message(content: content, isUserMessage: true));
      if (content.toLowerCase().contains('bağış yapmak istiyorum')) {
        messages.insert(
          0,
          Message(content: 'Bağış yapmak istiyorsanız IBAN numarası: XXXX-XXXX-XXXX-XXXX', isUserMessage: false),
        );
      } else {
        messages.insert(0, Message(content: 'Merhaba! Nasıl yardımcı olabilirim?', isUserMessage: false));
      }
    });
  }
}

String generateResponse(String message) {
  // Mesaja göre uygun bir otomatik cevap üretin ve döndürün
  return "Merhaba! Nasıl yardımcı olabilirim?";
}


class Message {
  final String content;
  final bool isUserMessage;

  Message({required this.content, required this.isUserMessage});
}