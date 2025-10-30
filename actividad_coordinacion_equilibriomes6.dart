import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class ActividadCoordinacionEquilibrioMes6 extends StatefulWidget {
  const ActividadCoordinacionEquilibrioMes6({Key? key}) : super(key: key);

  @override
  State<ActividadCoordinacionEquilibrioMes6> createState() =>
      _ActividadCoordinacionEquilibrioMes6State();
}

class _ActividadCoordinacionEquilibrioMes6State
    extends State<ActividadCoordinacionEquilibrioMes6> {
  bool _isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          // Fondo con gradiente
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFB2DFDB),
                  Color(0xFF80CBC4),
                  Color(0xFF4DB6AC),
                  Color(0xFF26A69A),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Visualizador con zoom del GIF
          InteractiveViewer(
            panEnabled: true,
            minScale: 0.8,
            maxScale: 5.0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 160),
                child: _isPlaying
                    ? Image.asset(
                        'assets/gifs/Mes6_Coordinación_equilibrio.gif',
                        gaplessPlayback: true,
                      )
                    : Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            )
                          ],
                        ),
                        child: const Text(
                          'GIF detenido ⏸️',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comic Sans MS',
                            color: Colors.black54,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          // Encabezado
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
                height: 110,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00796B), Color(0xFF004D40)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    '🌿 Coordinación y Equilibrio - Mes 6 🌿',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comic Sans MS',
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Contenedor de instrucciones
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: BounceInDown(
              duration: const Duration(milliseconds: 700),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.teal.shade700, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.psychology, color: Colors.teal, size: 30),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        '🧠 Estimula el equilibrio de tu bebé con esta actividad divertida.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Comic Sans MS',
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Botón de play/pausa
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                backgroundColor: Colors.teal.shade700,
                onPressed: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                },
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
