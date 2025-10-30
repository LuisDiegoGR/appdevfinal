import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadVistaTactoMes3 extends StatelessWidget {
  // URL completa de YouTube
  final String videoUrl = 'https://www.youtube.com/watch?v=wAu4tyA2zNo';

  Future<void> _launchVideo(BuildContext context) async {
    final Uri url = Uri.parse(videoUrl);
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
      backgroundColor: const Color(0xFFFCEBE0), // Fondo cálido
      appBar: AppBar(
        title: const Text(
          'Libro Pop-Up Sensorial',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF8E44AD), // Morado elegante
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Contenedor principal de la actividad
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.shade100.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Creación de un Libro Pop-Up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8E44AD),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Fomenta la creatividad y el sentido visual-táctil de tu bebé creando un libro interactivo con texturas, colores y movimiento.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _launchVideo(context),
                    icon: const Icon(Icons.play_circle_fill, size: 28),
                    label: const Text(
                      'Ver Video',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAF7AC5),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Contenedor de consejos
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFECE0F8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                '✨ Consejo: Utiliza papeles de colores, telas suaves, figuras en 3D y materiales reciclados para construir un libro interactivo. ¡Tu bebé lo amará!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF6C3483),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


