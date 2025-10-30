import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadDesarrolloVestibularPropioseptivoMes4 extends StatelessWidget {
  // URL completa de YouTube
  final String youtubeUrl = 'https://www.youtube.com/watch?v=SWZtq1DfJMc';

  Future<void> _launchURL(BuildContext context) async {
    final Uri url = Uri.parse(youtubeUrl);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el video en YouTube.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al abrir el video: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EC), // Fondo crema suave
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8B892), // Tono durazno suave
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Mes 4 - Estimulación Sensorial',
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.orangeAccent.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 4,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.child_friendly,
                  size: 90,
                  color: Color(0xFFE08E6D),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Desarrollo Vestibular y Propioceptivo',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6D4C41),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Estimula el equilibrio y la coordinación del bebé mediante juegos y ejercicios diseñados especialmente para su etapa de crecimiento.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF795548),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Botón confiable para abrir YouTube
                ElevatedButton.icon(
                  onPressed: () => _launchURL(context),
                  icon: const Icon(Icons.play_circle_fill, size: 28, color: Colors.white),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Ver Video',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE08E6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.deepOrangeAccent,
                    elevation: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

