import 'package:appdevfinal/Citas.dart';
import 'package:appdevfinal/consultar_especialista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quickalert/quickalert.dart';

class DetalleActividadPage extends StatefulWidget {
  final String actividad;

  const DetalleActividadPage({required this.actividad, Key? key}) : super(key: key);

  @override
  _DetalleActividadPageState createState() => _DetalleActividadPageState();
}

class _DetalleActividadPageState extends State<DetalleActividadPage> {
  int lenguajePuntaje = 1;
  int socialPuntaje = 1;
  int coordinacionPuntaje = 1;
  int motoraPuntaje = 1;

  int calcularPuntajeTotal() {
    return lenguajePuntaje + socialPuntaje + coordinacionPuntaje + motoraPuntaje;
  }

  void mostrarResultado() {
    int puntajeTotal = calcularPuntajeTotal();
    if (puntajeTotal >= 16) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: '¡Excelente!',
        text: 'El desarrollo del bebé está bien',
        confirmBtnText: 'OK',
      );
    } else if (puntajeTotal <= 8) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Atención necesaria',
        text: 'El desarrollo se está viendo afectado, consulta un especialista',
        confirmBtnText: 'Consulta',
        onConfirmBtnTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Citas()));
        },
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: '¡Alerta!',
        text: 'Hay áreas que necesitan atención. Agenda una cita.',
        confirmBtnText: 'Consulta',
        onConfirmBtnTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(builder: (_) =>  ConsultarEspecialista()));
        },
      );
    }
  }

  Widget buildDropdownCategory({
    required String title,
    required String description,
    required int value,
    required ValueChanged<int> onChanged,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.pinkAccent),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(description, style: const TextStyle(color: Colors.black87, fontSize: 16)),
          const SizedBox(height: 10),
          DropdownButton<int>(
            value: value,
            items: List.generate(5, (index) {
              return DropdownMenuItem(
                value: index + 1,
                child: Text('${index + 1}'),
              );
            }),
            onChanged: (newValue) => onChanged(newValue ?? 1),
            style: const TextStyle(color: Colors.black, fontSize: 18),
            dropdownColor: Colors.white,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE4E1), Color(0xFFFFC1E3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.purple),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        widget.actividad,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 500.ms),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7E8),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Escala de Evaluación',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.purple),
                        ),
                        SizedBox(height: 10),
                        Text('1 - No lo hace'),
                        Text('2 - Poco lo hace'),
                        Text('3 - A veces lo hace'),
                        Text('4 - Casi siempre lo hace'),
                        Text('5 - Lo hace'),
                      ],
                    ),
                  ).animate().fadeIn(duration: 700.ms),
                  const SizedBox(height: 20),
                  buildDropdownCategory(
                    title: 'Lenguaje:',
                    description: 'Llora, ríe, emite sonidos',
                    value: lenguajePuntaje,
                    onChanged: (value) => setState(() => lenguajePuntaje = value),
                    icon: Icons.baby_changing_station,
                  ),
                  buildDropdownCategory(
                    title: 'Social:',
                    description: 'Mira la cara, sonríe espontáneamente',
                    value: socialPuntaje,
                    onChanged: (value) => setState(() => socialPuntaje = value),
                    icon: Icons.face,
                  ),
                  buildDropdownCategory(
                    title: 'Coordinación:',
                    description: 'Sigue objetos con la mirada, busca el sonido',
                    value: coordinacionPuntaje,
                    onChanged: (value) => setState(() => coordinacionPuntaje = value),
                    icon: Icons.toys,
                  ),
                  buildDropdownCategory(
                    title: 'Motora:',
                    description: 'Boca abajo, levanta la cabeza',
                    value: motoraPuntaje,
                    onChanged: (value) => setState(() => motoraPuntaje = value),
                    icon: Icons.directions_run,
                  ),
                  const SizedBox(height: 48),
                  Center(
                    child: ElevatedButton(
                      onPressed: mostrarResultado,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Evaluar', style: TextStyle(color: Colors.white)),
                    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}






//'Lenguaje:'
//' Llora, ríe, emite sonidos'
//'Social:'
//' Mira la cara, sonríe espontáneamente'
//'Coordinación:'
//' Sigue con la mirada objetos móviles, busca con la mirada la fuente del sonido, mueve la cabeza y los ojos en busca del sonido. '
//'Motora:'
//' Boca abajo, levanta 45 grados la cabeza, tracciona hasta sentarse y mantiene erguida y firme la cabeza.'