import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadMotrizMes1 extends StatelessWidget {
  // URL completa de YouTube
  final String videoUrl = 'https://www.youtube.com/watch?v=7qTMmwUv2Mc';

  ActividadMotrizMes1({super.key});

  Future<void> _launchVideo(BuildContext context) async {
    final Uri url = Uri.parse(videoUrl);

    try {
      // Intentar abrir en app externa (YouTube o navegador)
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        // Si falla, mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el video.')),
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
      backgroundColor: const Color(0xFFF1F8E9), // Verde claro
      appBar: AppBar(
        title: const Text('Motricidad Mes 1'),
        backgroundColor: const Color(0xFF81C784), // Verde suave
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.fitness_center, size: 80, color: Color(0xFF66BB6A)),
                  const SizedBox(height: 16),
                  const Text(
                    'Actividad Motriz - Mes 1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Este video presenta ejercicios suaves para promover el desarrollo motriz en el primer mes de tu bebé.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _launchVideo(context),
                    icon: const Icon(Icons.play_circle_fill, color: Colors.white),
                    label: const Text(
                      'Ver Video',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF66BB6A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Consejo: coloca a tu bebé boca abajo bajo supervisión por breves momentos para estimular sus músculos del cuello y espalda.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.teal,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      ),
    );
  }
}
