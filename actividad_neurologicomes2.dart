import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadNeurologicoMes2 extends StatefulWidget {
  @override
  _ActividadNeurologicoMes2State createState() => _ActividadNeurologicoMes2State();
}

class _ActividadNeurologicoMes2State extends State<ActividadNeurologicoMes2> {
  final String videoUrl = 'https://www.youtube.com/watch?v=8eAFGYBKSBg';

  // Función para abrir el video en YouTube
  Future<void> _launchVideo() async {
    final Uri url = Uri.parse(videoUrl);

    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        // Mostrar mensaje si no se pudo abrir
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
      backgroundColor: Color(0xFFB2EBF2),
      appBar: AppBar(
        title: const Text('Video 3 - Estimulación Neurológica Mes 2'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Panel del video con bordes redondeados y sombra
                Container(
                  width: 320,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade100, Colors.teal],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.black.withOpacity(0.1),
                          child: const Center(
                            child: Icon(
                              Icons.play_circle_fill,
                              size: 80,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: _launchVideo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Títulos y descripción
                const Text(
                  'Estimulación Neurológica Mes 2',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Video para el desarrollo motor y sensorial de tu bebé',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.tealAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Botón grande y amigable para abrir el video
                ElevatedButton.icon(
                  onPressed: _launchVideo,
                  icon: const Icon(Icons.play_arrow, size: 28),
                  label: const Text(
                    'Ver Video en YouTube',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 6,
                    shadowColor: Colors.teal.withOpacity(0.5),
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




