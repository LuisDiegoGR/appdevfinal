import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadMotrizMes5 extends StatelessWidget {
  // URL completa de YouTube
  final String youtubeUrl = 'https://www.youtube.com/watch?v=eDnDNWXG6Tw';

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
      backgroundColor: const Color(0xFFF8F1E4), // Fondo beige muy claro
      appBar: AppBar(
        backgroundColor: const Color(0xFFBFA980), // Tono arena/marrón claro
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Mes 5 - Actividad Motriz',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Arial',
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.2),
                  blurRadius: 18,
                  spreadRadius: 5,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.directions_run,
                  size: 90,
                  color: Color(0xFF795548),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Actividad Motriz',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Apoya el desarrollo de las habilidades motoras de tu bebé con ejercicios guiados para el quinto mes.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6D4C41),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Botón confiable para abrir YouTube
                ElevatedButton.icon(
                  onPressed: () => _launchURL(context),
                  icon: const Icon(Icons.play_arrow, size: 28, color: Colors.white),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Ver Video',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8D6E63),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.brown.shade300,
                    elevation: 10,
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
