import 'package:appdevfinal/Citas.dart';
import 'package:appdevfinal/consultar_especialista.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class DetalleActividadPage3 extends StatefulWidget {
  const DetalleActividadPage3({super.key, required this.actividad});
  final String actividad;

  @override
  State<DetalleActividadPage3> createState() => _DetalleActividadPage3State();
}

class _DetalleActividadPage3State extends State<DetalleActividadPage3> {
  // Definir variables para almacenar los puntajes
  int lenguajePuntaje = 0;
  int socialPuntaje = 0;
  int coordinacionPuntaje = 0;
  int motoraPuntaje = 0;

  final TextEditingController lenguajeController = TextEditingController();
  final TextEditingController socialController = TextEditingController();
  final TextEditingController coordinacionController = TextEditingController();
  final TextEditingController motoraController = TextEditingController();

  // Método para leer el valor del TextField y asignarlo al puntaje
  void _leerValorDeTexto() {
    lenguajePuntaje = _obtenerPuntajeValido(lenguajeController.text);
    socialPuntaje = _obtenerPuntajeValido(socialController.text);
    coordinacionPuntaje = _obtenerPuntajeValido(coordinacionController.text);
    motoraPuntaje = _obtenerPuntajeValido(motoraController.text);
  }

  // Método para validar el valor ingresado y asegurarse de que esté entre 1 y 5
  int _obtenerPuntajeValido(String valor) {
    int valorInt = int.tryParse(valor) ?? 0;
    if (valorInt < 1 || valorInt > 5) {
      return 0; // Si el valor está fuera del rango, retornamos 0
    }
    return valorInt;
  }

  // Método para calcular el puntaje total
  int calcularPuntajeTotal() {
    return lenguajePuntaje + socialPuntaje + coordinacionPuntaje + motoraPuntaje;
  }

  // Método para mostrar el mensaje basado en el puntaje
  void mostrarResultado() {
    _leerValorDeTexto();

    int puntajeTotal = calcularPuntajeTotal();

    // Evaluamos el puntaje y mostramos el mensaje correspondiente
    if (puntajeTotal >= 16) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: '¡Desarrollo óptimo!',
        text: 'El desarrollo de tu bebé está excelente.',
        confirmBtnText: '¡Genial!',
      );
    } else if (puntajeTotal <= 8) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Atención urgente',
        text: 'Tu bebé necesita atención especializada. ¡Agenda una cita!',
        confirmBtnText: 'Consultar',
        onConfirmBtnTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Citas()),
          );
        },
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: 'Áreas que requieren atención',
        text: 'Algunas áreas necesitan seguimiento. Consulta a un especialista.',
        confirmBtnText: 'Consultar especialista',
        onConfirmBtnTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) =>  ConsultarEspecialista()),
          );
        },
      );
    }
  }

  // Función para crear un TextField para cada categoría
  Widget _buildTextInputCategory(String title, String description, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(color: Colors.black54, fontSize: 16),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            hintText: 'Ingresa un número entre 1 y 5',
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.blue.shade200, width: 2),
            ),
            filled: true,
            fillColor: Colors.blue.shade50,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.pink),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.actividad,
                      style: const TextStyle(
                        color: Colors.pink,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildTextInputCategory('Lenguaje', 'Lalea, “da-da”, “ma-ma”, “Agu”, utiliza las consonantes', lenguajeController),
                _buildTextInputCategory('Social', 'Encuentra objetos que se le ocultan bajo el pañal, es inicialmente tímido con extraños.', socialController),
                _buildTextInputCategory('Coordinación', 'Prensión entre la base del pulgar y el meñique, presión entre el pulgar y la base del dedo índice, prensión en pinza fina, opone el índice al pulgar', coordinacionController),
                _buildTextInputCategory('Motora', 'Se sienta solo sin apoyo, consigue pararse a apoyado en muebles, Gatea, camina apoyado en muebles', motoraController),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: mostrarResultado,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Enviar Evaluación',
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
//'Lalea, “da-da”, “ma-ma”, “Agu”, utiliza las consonantes',
//'Social:',
//'Encuentra objetos que se le ocultan bajo el pañal, es inicialmente tímido con extraños.',
//'Coordinación:',
//Prensión entre la base del pulgar y el meñique, presión entre el pulgar y la base del dedo índice, prensión en pinza fina, opone el índice al pulgar ',
//'Motora:'
//'Se sienta solo sin apoyo, consigue pararse a apoyado en muebles, Gatea, camina apoyado en muebles',