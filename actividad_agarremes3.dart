import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadAgarreMes3 extends StatelessWidget {
  final String videoUrl = "https://www.youtube.com/watch?v=PF5qfLMBkB8";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBE4D5),
      appBar: AppBar(
        title: Text(
          'Agarres - Mes 3',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange.shade300,
        elevation: 4,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('¡Actividad de estimulación para fortalecer el agarre del bebé!'),
                  backgroundColor: Colors.orange.shade200,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(
                  Icons.pan_tool_alt_rounded,
                  color: Colors.orange.shade400,
                  size: 120,
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade300,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.4),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    '📝 Instrucciones\n\nObserva este video y practica con tu bebé ejercicios de estimulación para fortalecer sus reflejos de agarre. ¡Verás grandes avances!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () => _launchURL(videoUrl),
                  icon: Icon(Icons.play_circle_fill, size: 36),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Ver Video',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    elevation: 10,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Estimulación Motora y Sensorial - Mes 3',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Actividad para desarrollar reflejo de agarre.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.orange.shade300.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir $url';
    }
  }
}





