import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quickalert/quickalert.dart';

class DetalleActividadPage extends StatefulWidget {
  final String actividad;

  DetalleActividadPage({required this.actividad});

  @override
  _DetalleActividadPageState createState() => _DetalleActividadPageState();
}

class _DetalleActividadPageState extends State<DetalleActividadPage> {
  int lenguajePuntaje = 0;
  int socialPuntaje = 0;
  int coordinacionPuntaje = 0;
  int motoraPuntaje = 0;

  int calcularPuntajeTotal() {
    return lenguajePuntaje + socialPuntaje + coordinacionPuntaje + motoraPuntaje;
  }

    void mostrarResultado() {
    int puntajeTotal = calcularPuntajeTotal();
    if (puntajeTotal >= 12) { // Suponiendo que el puntaje máximo por categoría es 3
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Evaluacion completada',
        text: 'El desarrollo del bebe esta bien',
        confirmBtnText: 'OK',
      );
    } else if (puntajeTotal <= 4 ){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Atencion al desarrollo',
        text: 'El desarrollo se esta viendo afectado consulta un especialista',
        confirmBtnText: 'Consulta',
      );
    } else {
      QuickAlert.show(
        context: context, 
        type: QuickAlertType.info,
        title: 'alerta de desarrollo',
        text: 'Hay áreas de desarrollo que necesitan atención. Por favor, agenda una cita.',
        confirmBtnText: 'Consulta',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.actividad),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Lenguaje:',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' Llora, ríe, emite sonidos',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              Slider(
                value: lenguajePuntaje.toDouble(),
                min: 0,
                max: 3,
                divisions: 3,
                label: lenguajePuntaje.toString(),
                activeColor: Colors.green,
                thumbColor: Colors.grey,
                onChanged: (double value) {
                  setState(() {
                    lenguajePuntaje = value.toInt();
                  });
                },
              ),
              SizedBox(height: 15),
              Image.asset(
                'assets/images/bebe-recien-nacido.png',
                 width: 300,
                 height: 300,
              ),
              SizedBox(height: 15),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Social:',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' Mira la cara, sonríe espontáneamente',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              Slider(
                value: socialPuntaje.toDouble(),
                min: 0,
                max: 3,
                divisions: 3,
                label: socialPuntaje.toString(),
                activeColor: Colors.green,
                thumbColor: Colors.grey,
                onChanged: (double value) {
                  setState(() {
                    socialPuntaje = value.toInt();
                  });
                },
              ),
              SizedBox(height: 24),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Coordinación:',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' Sigue con la mirada objetos móviles, busca con la mirada la fuente del sonido, mueve la cabeza y los ojos en busca del sonido. ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              Slider(
                value: coordinacionPuntaje.toDouble(),
                min: 0,
                max: 3,
                divisions: 3,
                label: coordinacionPuntaje.toString(),
                activeColor: Colors.green,
                thumbColor: Colors.grey,
                onChanged: (double value) {
                  setState(() {
                    coordinacionPuntaje = value.toInt();
                  });
                },
              ),
              SizedBox(height: 24),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Motora:',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' Boca abajo, levanta 45 grados la cabeza, tracciona hasta sentarse y mantiene erguida y firme la cabeza.',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              Slider(
                value: motoraPuntaje.toDouble(),
                min: 0,
                max: 3,
                divisions: 3,
                label: motoraPuntaje.toString(),
                activeColor: Colors.green,
                thumbColor: Colors.grey,
                onChanged: (double value) {
                  setState(() {
                    motoraPuntaje = value.toInt();
                  });
                },
              ),
              SizedBox(height: 80),
                Image.asset(
                  'assets/images/system-regular-56-warning.gif',
                  width: 70,
                  height: 70,
                ).animate().fadeIn(),
                SizedBox(height: 20),
                Text(
                  'Datos de alarma: No responde a estímulos fuertes, no sigue con la vista las cosas que se mueven, no se lleva las manos a la boca, no puede sostener la cabeza en alto cuando empuja el cuerpo hacia arriba estando boca abajo. ',
                  style: TextStyle(fontSize: 18),
                ).animate().fadeIn(delay: Duration(milliseconds: 500),
              ),
              SizedBox(height: 80),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.green, // Color del texto y del icono
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bordes redondeados
                  ),
                ),
                onPressed: mostrarResultado,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Evaluar'), 
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
