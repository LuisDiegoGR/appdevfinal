import 'package:appdevfinal/Citas.dart';
import 'package:appdevfinal/consultar_especialista.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class DetalleActividadPage4 extends StatefulWidget {
  const DetalleActividadPage4({super.key, required this.actividad});
  final String actividad;

  @override
  State<DetalleActividadPage4> createState() => _DetalleActividadPage4State();
}

class _DetalleActividadPage4State extends State<DetalleActividadPage4> {
  int lenguajePuntaje = 1;
  int socialPuntaje = 1;
  int coordinacionPuntaje = 1;
  int motoraPuntaje = 1;

  final List<String> puntajes = [
    'Nunca lo hace',
    'Casi nunca lo hace',
    'A veces lo hace',
    'Casi siempre lo hace',
    'Sí lo hace',
  ];

  int calcularPuntajeTotal() {
    return lenguajePuntaje + socialPuntaje + coordinacionPuntaje + motoraPuntaje;
  }

  void mostrarResultado() {
    int puntajeTotal = calcularPuntajeTotal();

    if (puntajeTotal >= 16) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Evaluación Completada',
        text: 'El desarrollo del bebé está bien.',
        confirmBtnText: 'OK',
      );
    } else if (puntajeTotal >= 9 && puntajeTotal <= 15) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'Alerta de Desarrollo',
        text: 'Algunas áreas necesitan atención.',
        confirmBtnText: 'OK',
      );
    } else if (puntajeTotal <= 8) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Alerta Crítica',
        text: 'Se recomienda consultar a un especialista.',
        confirmBtnText: 'Consultar especialista',
        onConfirmBtnTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  ConsultarEspecialista()),
        ),
      );
    }
  }

  Widget _buildDropdownCategory(String title, String description, int value, ValueChanged<int> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.purple.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Text(
          description,
          style: TextStyle(color: Colors.purple.shade600, fontSize: 16),
        ),
        const SizedBox(height: 10),
        DropdownButton<int>(
          value: value,
          onChanged: (int? newValue) {
            if (newValue != null) {
              setState(() {
                onChanged(newValue);
              });
            }
          },
          items: List.generate(5, (index) {
            return DropdownMenuItem<int>(
              value: index + 1,
              child: Text(
                '${index + 1}. ${puntajes[index]}',
                style: const TextStyle(color: Colors.black),
              ),
            );
          }),
          style: TextStyle(color: Colors.purple.shade800),
          iconEnabledColor: Colors.purple.shade800,
        ),
        const SizedBox(height: 20),
        Divider(color: Colors.purple.shade300, thickness: 1),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 240, 240),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.purple),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.actividad,
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Card(
                  color: Colors.purple.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Ponderación',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDropdownCategory(
                          'Lenguaje',
                          'Dada, mamá, pan, agua, oso.',
                          lenguajePuntaje,
                          (newValue) => lenguajePuntaje = newValue,
                        ),
                        _buildDropdownCategory(
                          'Social',
                          'Bebe de la taza, detiene la acción a la orden de ¡No!',
                          socialPuntaje,
                          (newValue) => socialPuntaje = newValue,
                        ),
                        _buildDropdownCategory(
                          'Coordinación',
                          'Prensión en pinza fina. Opone el índice al pulgar.',
                          coordinacionPuntaje,
                          (newValue) => coordinacionPuntaje = newValue,
                        ),
                        _buildDropdownCategory(
                          'Motricidad',
                          'Gatea, camina apoyado en muebles, camina tomado de la mano.',
                          motoraPuntaje,
                          (newValue) => motoraPuntaje = newValue,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: mostrarResultado,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple.shade500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          ),
                          child: const Text(
                            'Finalizar Evaluación',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
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







//'Lenguaje:',
//'Dada, mamá, pan, agua, oso.',

//'Social:',
//' Bebe de la tasa, detiene la acción a la orden de ¡No!',

//'Coordinación:',
//'Prensión en pinza fina. Opone el índice al pulgar ',

//'Motora:',
//' Gatea, camina apoyado en muebles, camina tomado de la mano.',