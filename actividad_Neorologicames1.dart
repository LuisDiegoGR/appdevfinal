import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Video3Page extends StatelessWidget {
  final String videoUrl = 'https://www.youtube.com/watch?v=AuCh4BvoD3Q';

  void _launchURL() async {
    final Uri url = Uri.parse('https://www.youtube.com/watch?v=AuCh4BvoD3Q');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir el enlace: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video 3 - Estimulación Neurológica'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFAF1F1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.video_collection, size: 100, color: Colors.pinkAccent),
              SizedBox(height: 30),
              Text(
                'Estimulación Neurológica y Propioceptiva',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Da clic en el botón para ir al video de la terapia:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.pinkAccent.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _launchURL,
                icon: Icon(Icons.play_circle_fill, color: Colors.white),
                label: Text(
                  'Ver video en YouTube',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  shadowColor: Colors.pinkAccent.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




























