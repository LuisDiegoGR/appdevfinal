import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadDesarrolloMotrizMes2 extends StatelessWidget {
  const ActividadDesarrolloMotrizMes2({Key? key}) : super(key: key);

  void _launchVideo() async {
    final Uri url = Uri.parse('https://youtu.be/EdWg_tqWArw');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir el enlace $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo con gradiente suave
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFF1F8F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Encabezado con ícono y texto
                Row(
                  children: const [
                    Icon(Icons.child_care, color: Colors.teal, size: 36),
                    SizedBox(width: 10),
                    Text(
                      'Desarrollo Motriz - Mes 2',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // Tarjeta principal con sombra
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '🍼 Actividad de Estimulación Motriz',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '📌 Descripción:\n'
                        'Coloca al bebé sobre su pancita (boca abajo) y deja que trate de levantar la cabeza. '
                        'Puedes usar juguetes llamativos frente a él para animarlo.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '🎯 Objetivo:\n'
                        'Fortalecer músculos del cuello y hombros, base para voltearse y sentarse pronto.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Botón atractivo para ir a sesión
                ElevatedButton.icon(
                  onPressed: _launchVideo,
                  icon: const Icon(Icons.play_circle_outline, size: 28),
                  label: const Text(
                    'Acceder a sesión',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                    shadowColor: Colors.tealAccent,
                  ),
                ),

                const Spacer(),

                // Botón de marcar como completado
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✅ Actividad marcada como completada'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle, color: Colors.green),
                  label: const Text(
                    'Marcar como completada',
                    style: TextStyle(fontSize: 16, color: Colors.green),
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



