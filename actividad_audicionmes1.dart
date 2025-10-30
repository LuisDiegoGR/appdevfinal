import 'package:flutter/material.dart';

class ActividadAudicionMes1 extends StatefulWidget {
  const ActividadAudicionMes1({Key? key}) : super(key: key);

  @override
  State<ActividadAudicionMes1> createState() => _ActividadAudicionMes1State();
}

class _ActividadAudicionMes1State extends State<ActividadAudicionMes1> with TickerProviderStateMixin {
  final List<String> palabras = [
    'mamá', 'papá', 'hola', 'amor', 'bebé', 'sí', 'aquí', 'corazón', 'dulce', 'luz',
    'abrazo', 'besito', 'cariño', 'sol', 'estrella', 'ángel', 'nene', 'nena', 'feliz', 'brilla'
  ];

  int indexActual = 0;

  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  void siguientePalabra() {
    setState(() {
      indexActual = (indexActual + 1) % palabras.length;
    });
  }

  void palabraAnterior() {
    setState(() {
      indexActual = (indexActual - 1 + palabras.length) % palabras.length;
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palabra = palabras[indexActual];

    return Scaffold(
      body: Stack(
        children: [
          // Fondo alegre decorativo
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFFDE7), Color(0xFFF8BBD0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Nubes decorativas
          Positioned(top: 50, left: 30, child: nubeSuave(100)),
          Positioned(top: 80, right: 40, child: nubeSuave(80)),
          Positioned(top: 120, left: 100, child: nubeSuave(60)),

          // Esferas o flores decorativas abajo
          Positioned(bottom: 20, left: 20, child: florDecorativa()),
          Positioned(bottom: 40, right: 30, child: florDecorativa()),
          Positioned(bottom: 60, left: 80, child: florDecorativa()),

          // Contenido principal
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'Actividad Auditiva 🎶',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[900],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '🎵 Di la palabra:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.purple),
                  ),
                  const SizedBox(height: 16),

                  AnimatedBuilder(
                    animation: _floatAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatAnimation.value),
                        child: child,
                      );
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.5),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(opacity: animation, child: child),
                        );
                      },
                      child: Container(
                        key: ValueKey<String>(palabra),
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(2, 4)),
                          ],
                        ),
                        child: Text(
                          palabra,
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6A1B9A),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    '🗣 Háblasela a tu bebé en un tono suave',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '🔁 Repítela 3 veces',
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: palabraAnterior,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Regresar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[200],
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: siguientePalabra,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Siguiente'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[300],
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Actividad marcada como completada')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Marcar como completada',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nubeSuave(double size) {
    return Container(
      width: size,
      height: size * 0.6,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

  Widget florDecorativa() {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.pinkAccent,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 4)],
      ),
    );
  }
}




