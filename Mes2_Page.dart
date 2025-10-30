import 'package:flutter/material.dart';
import 'actividad_vistames2.dart';
import 'actividad_tactomes2.dart';
import 'actividad_audicionmes2.dart';
import 'actividad_neurologicomes2.dart';
import 'actividad_olfatomes2.dart';
import 'actividad_Desarrollo_motrizmes2.dart';

class Mes2_Page extends StatelessWidget {
  const Mes2_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7), // Fondo muy claro
      appBar: AppBar(
        title: const Text("Mes 2 - Alternativa"),
        backgroundColor: const Color(0xFFD6EAF8), // Azul muy suave (angelical)
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "ACTIVIDADES DEL MES 2",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6A7BA2), // Azul cielo tenue
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "Estas actividades están pensadas para estimular el desarrollo de tu bebé en su segundo mes. Aunque no sean obligatorias, puedes explorarlas libremente si deseas reforzar algunas áreas con amor y tranquilidad.",
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF5D6D7E),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            _actividadButton(
              context,
              "Actividad Visual",
              Icons.visibility_outlined,
              const Color(0xFFFFE0E9), // Rosa suave
               ActividadVistaMes2(),
            ),
            _actividadButton(
              context,
              "Actividad Tacto",
              Icons.touch_app_outlined,
              const Color(0xFFFFF3C1), // Amarillo pastel
               ActividadTactoMes2(),
            ),
            _actividadButton(
              context,
              "Actividad Audición",
              Icons.hearing_outlined,
              const Color(0xFFDEF5E5), // Verde muy claro
            ActividadAudicionMes2Page(),
            ),
            _actividadButton(
              context,
              "Actividad Neurológica",
              Icons.psychology_outlined,
              const Color(0xFFD6EAF8),
            ActividadNeurologicoMes2(),
            ),
            _actividadButton(
              context,
              "Actividad Olfato",
              Icons.spa_outlined,
              const Color(0xFFFDEDEC),
              const ActividadOlfatoMes2(),
            ),
            _actividadButton(
              context,
              "Desarrollo Motriz",
              Icons.directions_walk_outlined,
              const Color(0xFFF9EBEA),
              const ActividadDesarrolloMotrizMes2(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actividadButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget nextPage,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(60),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF4A4A4A)),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF4A4A4A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

