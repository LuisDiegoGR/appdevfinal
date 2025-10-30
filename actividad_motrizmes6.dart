import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadMotrizMes6 extends StatelessWidget {
  final String videoUrl = 'https://www.youtube.com/watch?v=YJUuFsDW3dI';

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
      backgroundColor: const Color(0xFFF0F8FF),
      appBar: AppBar(
        title: const Text('Estimulación Motriz - Mes 6'),
        backgroundColor: const Color(0xFF6EC6FF),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.fitness_center, size: 80, color: Color(0xFF6EC6FF)),
                  const SizedBox(height: 16),
                  const Text(
                    'Actividad Motriz - Mes 6',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0077B6),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Mira este video para aprender sobre las actividades motrices recomendadas para tu bebé en el sexto mes.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
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
                      backgroundColor: const Color(0xFF6EC6FF),
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
            Text(
              'Consejo: Ayudar a tu bebé a desarrollar sus habilidades motrices puede incluir actividades como el movimiento de brazos y piernas, siempre con cuidado y supervisión.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

