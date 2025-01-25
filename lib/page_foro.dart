import 'package:appdevfinal/ForoDiscussion.dart';
import 'package:appdevfinal/informacion1.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PageForo extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await Future.delayed(Duration(milliseconds: 50));
    await _audioPlayer
        .setVolume(0.050); // Volumen a la mitad (rango de 0.0 a 1.0)
    await _audioPlayer.play(AssetSource('sounds/click-button-app-147358.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Informacion1()));
            },
          ),
          title: const Text('Foro de discusión'),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF), // Blanco puro
                Color.fromARGB(255, 233, 233, 233), // Gris oscuro
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    color: Colors.white,
                    shadowColor: Colors.black.withOpacity(0.5),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Objetivo',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Promover el intercambio de experiencias, conocimientos y estrategias entre padres de familia sobre la rehabilitación pediátrica, con el propósito de fortalecer el acompañamiento emocional y mejorar el bienestar integral de los niños en tratamiento.',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    color: Colors.white,
                    shadowColor: Colors.black.withOpacity(0.5),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Sugerencias',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Escucha las opiniones y experiencias de otros padres con empatía, Este es un espacio seguro, todos estamos aquí para aprender y apoyarnos mutuamente, No compartas información personal o médica de terceros.',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  RawMaterialButton(
                    fillColor: const Color.fromARGB(255, 46, 46, 46),
                    elevation: 8,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () async {
                      await _playSound();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Forodiscussion()));
                    },
                    child: const Text(
                      'Ver Foros',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
