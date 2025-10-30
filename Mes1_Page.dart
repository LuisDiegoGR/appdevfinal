import 'package:flutter/material.dart';
import 'actividad_vistames1.dart';
import 'actividad_olfatomes1.dart';
import 'actividad_motrizmes1.dart';
import 'actividad_Desarrollo_vestibularmes1.dart';
import 'actividad_Neorologicames1.dart';
import 'actividad_audicionmes1.dart';


class Mes1_Page extends StatelessWidget {
  const Mes1_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB), // Fondo suave
      appBar: AppBar(
        title: const Text("Mes 1 - Alternativa"),
        backgroundColor: const Color(0xFFB3CDE0), // Azul pastel
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "ACTIVIDADES DEL MES 1",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5D6D7E), // Gris azulado
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "No te preocupes, estas actividades no es necesario realizarlas ya que tu bebé tiene más de 4 semanas de edad. Prosigue con el programa de actividades del calendario, pero puedes echarle un vistazo a las actividades del mes 1.",
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
              Icons.remove_red_eye_outlined,
              const Color(0xFFAEDFF7),
              const EstimVistaMes1(),
            ),
            _actividadButton(
              context,
              "Actividad Olfato",
              Icons.spa_outlined,
              const Color(0xFFD4E6B5),
              const ActividadOlfatoMes1(),
            ),
            _actividadButton(
              context,
              "Actividad Motriz",
              Icons.directions_walk_outlined,
              const Color(0xFFFFE3B3),
               ActividadMotrizMes1(),
            ),
            _actividadButton(
              context,
              "Desarrollo Vestibular",
              Icons.accessibility_new_outlined,
              const Color(0xFFE8DAEF),
              JuegoPage(),
            ),
            _actividadButton(
              context,
              "Actividad Neurológica",
              Icons.psychology_alt_outlined,
              const Color(0xFFFADBD8),
               Video3Page(),
            ),
            _actividadButton(
              context,
              "Actividad Audición",
              Icons.hearing_outlined,
              const Color(0xFFB2EBF2),
              const ActividadAudicionMes1(),
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
          elevation: 2,
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


