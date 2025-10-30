import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class EstimVistaMes1 extends StatefulWidget {
  const EstimVistaMes1({Key? key}) : super(key: key);

  @override
  _EstimVistaMes1State createState() => _EstimVistaMes1State();
}

class _EstimVistaMes1State extends State<EstimVistaMes1>
    with SingleTickerProviderStateMixin {
  final List<String> caras = ['😊', '😛', '😲', '😉', '😡', '😭'];
  final StreamController<int> controller = StreamController<int>();
  String? resultado;

  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _scaleAnimation =
        CurvedAnimation(parent: _animController, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    controller.close();
    _animController.dispose();
    super.dispose();
  }

  void girarRuleta() {
    final randomIndex = Random().nextInt(caras.length);
    controller.add(randomIndex);
    setState(() {
      resultado = caras[randomIndex];
    });
    _animController.forward(from: 0); // dispara animación
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estimulación Visual - Mes 1'),
        backgroundColor: Colors.deepPurple.shade400,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade200, Colors.pink.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 6,
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    '🎡 Gira la ruleta y realiza la cara que aparezca frente a tu bebé '
                    'para estimular su reconocimiento visual y emocional 👶💜',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: FortuneWheel(
                      selected: controller.stream,
                      indicators: const <FortuneIndicator>[
                        FortuneIndicator(
                          alignment: Alignment.topCenter,
                          child: TriangleIndicator(
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                      items: [
                        for (var cara in caras)
                          FortuneItem(
                            child: Text(
                              cara,
                              style: const TextStyle(fontSize: 50),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: girarRuleta,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 6,
                ),
                icon: const Icon(Icons.casino, color: Colors.white, size: 28),
                label: const Text(
                  'Girar Ruleta',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              if (resultado != null) ...[
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Text(
                    '👉 ¡Haz esta cara: $resultado!',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Muéstrala frente a tu bebé y repítela varias veces '
                  'para estimular su vista y emociones 💕',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}



