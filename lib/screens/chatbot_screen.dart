import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    loadMessages(); 
    checkConnectivity(); 
  }

  // Función para verificar la conectividad de Internet
  void checkConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = result != ConnectivityResult.none;
    });

    // Escuchar los cambios en la conectividad
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        isConnected = result != ConnectivityResult.none;
      });
    });
  }

  // Función para cargar mensajes desde SharedPreferences
  Future<void> loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedMessages = prefs.getString('chatHistory');

    if (storedMessages != null) {
      print('Messages loaded from SharedPreferences: $storedMessages');

      // Convertir cada elemento a Map<String, String> explícitamente
      List<dynamic> decodedList = json.decode(storedMessages);

      setState(() {
        messages = decodedList.map((message) {
          return Map<String, String>.from(message); // Conversión explícita
        }).toList();
        print('Messages after conversion: $messages');
      });
    } else {
      print('No messages found in SharedPreferences');
    }
  }

  Future<void> clearMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .remove('chatHistory'); // Eliminar la clave que guarda los mensajes

    setState(() {
      messages.clear(); // Limpiar la lista de mensajes en la interfaz
    });

    print('Conversación eliminada');
  }

  Future<void> saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonMessages = json.encode(messages);
    await prefs.setString('chatHistory', jsonMessages);

    print(
        'Messages saved in SharedPreferences: $jsonMessages'); // Verificar si se está guardando correctamente
  }

  // Función para enviar el mensaje del usuario
  void sendMessage() async {
    if (_controller.text.isEmpty) return;

    String userMessage = _controller.text;
    setState(() {
      messages.add({'role': 'user', 'message': userMessage});
    });

    // Guardar mensaje del usuario en SharedPreferences
    await saveMessages();
    _controller.clear();

    //le enviamos el historial completo
    String context = messages
        .map((message) => '${message['role']} : ${message['message']}')
        .join('\n');
    // Obtener la respuesta del chatbot
    String botResponse = await apiService.getResponse(context);

    setState(() {
      messages.add({'role': 'bot', 'message': botResponse});
    });

    // Guardar respuesta del bot en SharedPreferences
    await saveMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Chatbot YAMA',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white)),
        actions: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                ),
              )),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: clearMessages,
            tooltip: 'Eliminar conversación',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message['role'] == 'user';

                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.green : Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message['message']!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      hintStyle: TextStyle(fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.5,
                      )),
                    ),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: isConnected ? sendMessage : null),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
