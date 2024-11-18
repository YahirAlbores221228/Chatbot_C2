import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: -100,
            top: 100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ).animate().move(duration: 3.seconds).scaleXY(end: 1.2, begin: 0.9),
          ),
          Positioned(
            right: -120,
            bottom: 80,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.indigoAccent.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ).animate().move(duration: 4.seconds).scaleXY(end: 1.1, begin: 0.8),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: const AssetImage('assets/logo.jpg'),
                  radius: 80,
                )
                    .animate()
                    .scale(duration: 1.seconds, curve: Curves.easeOutBack),
                const SizedBox(height: 25),
                const Text(
                  'Chatbot VIA',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 7, 128, 27),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 1.seconds, delay: 500.ms),
                const SizedBox(height: 20),
                const Text(
                  'Yahir Alberto Albores Madrigal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigoAccent,
                  ),
                ).animate().fadeIn(delay: 1.seconds),
                const SizedBox(height: 20),
                const Text(
                  'Ingeniería en Software',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple,
                    fontSize: 16,
                  ),
                ).animate().fadeIn(delay: 1.5.seconds),
                const SizedBox(height: 20),
                const Text(
                  '221228',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple,
                    fontSize: 16,
                  ),
                ).animate().fadeIn(delay: 2.seconds),
                const SizedBox(height: 20),
                const Text(
                  'Promoción para Móvil',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple,
                    fontSize: 16,
                  ),
                ).animate().fadeIn(delay: 2.5.seconds),
                const SizedBox(height: 20),
                const Text(
                  'Grupo: B',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple,
                    fontSize: 16,
                  ),
                ).animate().fadeIn(delay: 3.seconds),
                const SizedBox(height: 30),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/iconsgit2.svg',
                    height: 50,
                    width: 50,
                  ).animate().scale(duration: 1.seconds),
                  iconSize: 50,
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    launch(
                        "https://github.com/YahirAlbores221228/Chatbot_C2.git");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
