import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class ActividadNeurologicoMes6 extends StatelessWidget {
  const ActividadNeurologicoMes6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F7),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: const Color(0xFFDABBE5),
        child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
      ),
      body: Stack(
        children: [
          // Título
          Positioned(
            top: 60,
            left: 30,
            right: 30,
            child: Animate(
              effects: const [FadeEffect(duration: Duration(milliseconds: 800))],
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBEAF2),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.shade100.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Text(
                  '✨ Actividad Neurológica - Mes 6 ✨',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF844685),
                  ),
                ),
              ),
            ),
          ),

          // Instrucción
          Positioned(
            top: 140,
            left: 30,
            right: 30,
            child: Animate(
              effects: const [SlideEffect(begin: Offset(0, 0.3), duration: Duration(milliseconds: 900))],
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.pink.shade100, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.shade100.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Column(
                  children: const [
                    Icon(Icons.self_improvement, color: Colors.purpleAccent, size: 30),
                    SizedBox(height: 10),
                    Text(
                      'Realiza esta actividad siguiendo los pasos.\nPuedes hacer zoom para observar con detalle.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4B4B4B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // GIF con zoom
          Positioned.fill(
            top: 250,
            child: Animate(
              effects: const [FadeEffect(duration: Duration(milliseconds: 1000))],
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 1,
                maxScale: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/gifs/Mes6_Neurologico.gif',
                      fit: BoxFit.contain,
                    ),
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
