import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
      child: Stack(children: [
        Positioned(
            left: -80,
            bottom: 50,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(150)),
            )),
        Positioned(
            right: -80,
            top: 50,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(150)),
            )),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/logo.jpg'),
              radius: 80,
            ),
            const SizedBox(height: 25),
            const Text('Yahir Alberto Albores Madrigal',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigoAccent)),
            const SizedBox(height: 20),
            const Text(
              'Ingeneria en software ',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                  fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text('221228',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple,
                    fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              'Promacion para movil',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                  fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Grupo: B',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                  fontSize: 16),
            ),
            IconButton(
                icon: SvgPicture.asset('assets/iconsgit2.svg',
                    height: 50, width: 50),
                iconSize: 50,
                padding: const EdgeInsets.all(10),
                onPressed: () {
                  launch("https://github.com/YahirAlbores221228/Chatbot_C2.git");
                }),
          ],
        )),
      ]),
    ));
  }
}
