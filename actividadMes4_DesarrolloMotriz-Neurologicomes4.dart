import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadMes4DesarrolloMotrizNeurologico extends StatelessWidget {
  // URL completa de YouTube
  final String youtubeUrl = 'https://www.youtube.com/watch?v=Vuvz7jVkvPs';

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
      backgroundColor: const Color(0xFFF0F8FF), // Fondo azul claro
      appBar: AppBar(
        title: const Text(
          'Mes 4: Desarrollo Motriz y Neurológico',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: const Color(0xFF87CEEB),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.child_friendly,
              size: 100,
              color: Color(0xFF87CEFA),
            ),
            const SizedBox(height: 30),

            // Botón para abrir YouTube
            ElevatedButton.icon(
              onPressed: () => _launchURL(context),
              icon: const Icon(Icons.play_circle_fill, size: 28, color: Colors.white),
              label: const Text(
                'Ver Video en YouTube',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00BFFF),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
                shadowColor: Colors.lightBlueAccent,
              ),
            ),
            const SizedBox(height: 30),

            // Títulos y descripción
            const Text(
              'Actividad de Estimulación',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4682B4),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Este video guía actividades que estimulan el desarrollo motriz y neurológico de tu bebé durante el cuarto mes.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF4682B4),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

