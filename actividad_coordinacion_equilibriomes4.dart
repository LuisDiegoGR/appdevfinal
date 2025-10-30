import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class ActividadCoordinacionEquilibrio extends StatefulWidget {
  const ActividadCoordinacionEquilibrio({Key? key}) : super(key: key);

  @override
  State<ActividadCoordinacionEquilibrio> createState() =>
      _ActividadCoordinacionEquilibrioState();
}

class _ActividadCoordinacionEquilibrioState
    extends State<ActividadCoordinacionEquilibrio> {
  bool _isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
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
                  Color(0xFFFFE0B2),
                  Color(0xFFFFCDD2),
                  Color(0xFFE1BEE7),
                  Color(0xFFB2EBF2),
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
                        'assets/gifs/Mes4_Coordinación_equilibrio.gif',
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
                    colors: [Color(0xFFF06292), Color(0xFFBA68C8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
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
                    '⚖️ Coordinación y Equilibrio - Mes 4 ⚖️',
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
                  border: Border.all(color: Colors.deepPurple, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.balance, color: Colors.purple, size: 30),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        '💡 Observa la actividad y realiza los movimientos con tu bebé.',
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
                backgroundColor: Colors.deepPurple,
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
