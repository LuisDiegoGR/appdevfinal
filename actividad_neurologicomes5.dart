import 'package:flutter/material.dart';

class ActividadNeurologicoMes5 extends StatelessWidget {
  const ActividadNeurologicoMes5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan.shade300,
        child: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          // Fondo Era de Hielo
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFBBDEFB),
                  Color(0xFFE1F5FE),
                  Color(0xFFB3E5FC),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // AppBar personalizada Era de Hielo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.cyan.shade300,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    '❄️ Era de Hielo | Actividad Mes 5 ❄️',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ComicSans',
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Tarjeta de instrucción Era de Hielo
          Positioned(
            top: 130,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.cyan.shade200, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan.shade100,
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Row(
                children: const [
                  Icon(Icons.ac_unit, color: Colors.blueAccent, size: 30),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '🦣 Realiza esta actividad siguiendo los pasos.\n(Puedes hacer zoom con dos deditos 🐾)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'ComicSans',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Imagen con zoom nativo y movimiento
          Positioned.fill(
            top: 250,
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.8,
              maxScale: 5.0,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'assets/gifs/Mes5_Neurológico.gif',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
