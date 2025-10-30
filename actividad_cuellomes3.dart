import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadCuelloMes3 extends StatelessWidget {
  final String videoUrl = 'https://www.youtube.com/watch?v=J7u2uXqRlU8';

  Future<void> _launchVideo() async {
    final Uri url = Uri.parse(videoUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir el video: $videoUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actividad Cuello Mes 3'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFf0f8ff),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
                width: 340,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade100, Colors.blue.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.play_circle_fill,
                    size: 80,
                    color: Colors.white,
                  ),
                  onPressed: _launchVideo,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Estimulación Cuello - Mes 3',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Ejercicio para fortalecer la musculatura del cuello de tu bebé. Presiona el botón para ver el video completo desde YouTube.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.lightBlueAccent.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _launchVideo,
                icon: Icon(Icons.video_library, color: Colors.white),
                label: Text(
                  'Ver Video en YouTube',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}


