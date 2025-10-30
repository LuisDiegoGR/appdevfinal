import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';

class ActividadOlfatoMes5 extends StatefulWidget {
  @override
  _ActividadOlfatoMes5State createState() => _ActividadOlfatoMes5State();
}

class _ActividadOlfatoMes5State extends State<ActividadOlfatoMes5> {
  final List<String> _productos = ['🧴', '🧼', '🍼', '🧷', '🧻', '🛁'];
  final List<String> _nombres = [
    'Shampoo',
    'Jabón',
    'Leche o fórmula',
    'Aceite corporal',
    'Toallitas húmedas',
    'Baño de tina'
  ];

  int _emoji1 = 0;
  int _emoji2 = 1;
  int _emoji3 = 2;
  String? _productoElegido;
  bool _esTriple = false;
  bool _isSpinning = false;

  ConfettiController? _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController?.dispose();
    super.dispose();
  }

  Future<void> _girarSlotMachine() async {
    if (_isSpinning) return;
    _isSpinning = true;
    _esTriple = false;
    final random = Random();

    for (int i = 0; i < 15; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      setState(() {
        _emoji1 = random.nextInt(_productos.length);
        _emoji2 = random.nextInt(_productos.length);
        _emoji3 = random.nextInt(_productos.length);
      });
    }

    final e1 = random.nextInt(_productos.length);
    setState(() {
      _emoji1 = e1;
    });

    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      setState(() {
        _emoji2 = random.nextInt(_productos.length);
        _emoji3 = random.nextInt(_productos.length);
      });
    }

    final e2 = random.nextInt(_productos.length);
    setState(() {
      _emoji2 = e2;
    });

    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      setState(() {
        _emoji3 = random.nextInt(_productos.length);
      });
    }

    final e3 = random.nextInt(_productos.length);
    setState(() {
      _emoji3 = e3;
    });

    _productoElegido = _nombres[_emoji2];
    _esTriple = (_emoji1 == _emoji2 && _emoji2 == _emoji3);

    if (_esTriple) {
      _confettiController?.play();
    }

    _isSpinning = false;
  }

  void _registrarReaccion(String emocion) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registraste la reacción: $emocion'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFEE3EC), Color(0xFFF7F3FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text(
                      '🎲 Gira la ruleta de olores',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 30),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildAnimatedEmoji(_emoji1),
                          _buildAnimatedEmoji(_emoji2),
                          _buildAnimatedEmoji(_emoji3),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton.icon(
                      onPressed: _girarSlotMachine,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Girar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade400,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textStyle: const TextStyle(fontSize: 18),
                        elevation: 6,
                      ),
                    ),

                    const SizedBox(height: 30),

                    if (_esTriple)
                      Column(
                        children: const [
                          Text(
                            '¡Felicidades! 🎉',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '¡Obtuviste tres productos iguales!',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 30),
                          Text('👶', style: TextStyle(fontSize: 100)),
                        ],
                      )
                    else if (_productoElegido != null)
                      Column(
                        children: [
                          Text(
                            '👃 Producto sugerido: $_productoElegido',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '¿Cómo reaccionó tu bebé al olor?',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildEmojiButton('🤩', 'Le gustó', Colors.green),
                              _buildEmojiButton('😭', 'No le gustó', Colors.red),
                              _buildEmojiButton('😳', 'Se confundió', Colors.orange),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            // CONFETTI
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController!,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: [Colors.purple, Colors.pink, Colors.yellow, Colors.green],
                gravity: 0.3,
                numberOfParticles: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedEmoji(int index) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      child: Text(
        _productos[index],
        key: ValueKey<int>(index),
        style: const TextStyle(fontSize: 50),
      ),
    );
  }

  Widget _buildEmojiButton(String emoji, String label, Color color) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _registrarReaccion("$emoji $label"),
          child: Text(emoji, style: const TextStyle(fontSize: 30)),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: color,
            elevation: 6,
          ),
        ),
        const SizedBox(height: 8),
        Text(label)
      ],
    );
  }
}




