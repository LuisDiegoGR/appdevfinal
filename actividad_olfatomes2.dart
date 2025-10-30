import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart'; // Asegúrate de tener animate_do en pubspec.yaml

class ActividadOlfatoMes2 extends StatelessWidget {
  const ActividadOlfatoMes2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          // Fondo degradado suave
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF9575CD), Color(0xFFE1BEE7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Imagen con zoom pantalla completa
          InteractiveViewer(
            panEnabled: true,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            minScale: 0.8,
            maxScale: 5.0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Image.asset(
                  'assets/gifs/Mes2_Olfato.gif',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // AppBar personalizada
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade700,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Actividad Olfato Mes 2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Tarjeta flotante con animación y texto
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: BounceInDown(
              duration: const Duration(milliseconds: 700),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.star_rounded, color: Colors.deepPurple, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '✨ Realiza esta actividad, sigue los pasos ✨',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

