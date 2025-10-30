import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadVistaMes2 extends StatefulWidget {
  @override
  _ActividadVistaMes2State createState() => _ActividadVistaMes2State();
}

class _ActividadVistaMes2State extends State<ActividadVistaMes2> {
  final String videoUrl = 'https://www.youtube.com/watch?v=a8I77CAilXE';

  Future<void> _launchVideo() async {
    final Uri url = Uri.parse(videoUrl);

    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
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
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        title: const Text(
          "👶 Actividad: Vista Mes 2 👶",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
          child: Column(
            children: [
              // Panel de video con sombra y bordes redondeados
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurpleAccent.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        color: Colors.deepPurpleAccent.withOpacity(0.1),
                        child: const Center(
                          child: Icon(
                            Icons.play_circle_fill,
                            size: 90,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _launchVideo,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Botón grande y llamativo para abrir el video
              ElevatedButton.icon(
                onPressed: _launchVideo,
                icon: const Icon(Icons.play_arrow, size: 28),
                label: const Text(
                  'Ver video en YouTube',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 8,
                  shadowColor: Colors.deepPurpleAccent.withOpacity(0.4),
                ),
              ),
              const SizedBox(height: 40),

              // Contenedor con la descripción de la actividad
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurpleAccent.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    Text(
                      "Este video está diseñado para estimular el desarrollo visual del bebé durante el mes 2. "
                      "Sigue las indicaciones y observa cómo responde tu bebé a los ejercicios.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "👶 Información de la Actividad 👶",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Este video está diseñado para estimular el desarrollo visual del bebé durante el mes 2. "
            "Es importante observar las reacciones del bebé y seguir las pautas de estimulación adecuadas.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cerrar",
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}






