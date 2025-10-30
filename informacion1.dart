import 'dart:math';
import 'package:flutter/material.dart';

import 'InicioApp.dart';
import 'Rincon_bebe.dart';
import 'page_embarazo.dart';
import 'page_estimulacion.dart';
import 'page_foro.dart';

class Informacion1 extends StatefulWidget {
  const Informacion1({super.key});

  @override
  State<Informacion1> createState() => _Informacion1State();
}

class _Informacion1State extends State<Informacion1>
    with TickerProviderStateMixin {
  final List<String> _imageUrls = [
    'assets/images/estimulacion.png',
    'assets/images/embarazo.png',
    'assets/images/niña.png',
    'assets/images/foro.png',
  ];

  final List<String> _titles = [
    'Estimulación Temprana',
    'Datos curiosos',
    'Rincón del bebé',
    'Foro de Discusión',
  ];

  final List<IconData> _icons = [
    Icons.star_rounded,
    Icons.lightbulb_outline,
    Icons.child_care,
    Icons.forum_rounded,
  ];

  final List<Widget> _pages = [
    const PageEstimulacion(),
    PageEmbarazo(),
    const EvaluaTemp(),
    PageForo(),
  ];

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _bubblesController;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);
    _fadeController.forward();

    _bubblesController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _bubblesController.dispose();
    super.dispose();
  }

  Widget _buildCustomCard(
    BuildContext context,
    String imagePath,
    String text,
    IconData icon,
    Function() onPressed, {
    List<Color>? gradientColors,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Container(
            width: 260, // 🔹 Más angosto
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors ??
                    [Colors.pink.shade100, Colors.blue.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.black54, size: 26),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18, // 🔹 Más compacto
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    imagePath,
                    width: 120, // 🔹 Imagen más pequeña
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade300,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 5,
                  ),
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  label: const Text(
                    "Ver más",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pastelPalettes = [
      [Colors.pink.shade100, Colors.yellow.shade100],
      [Colors.blue.shade100, Colors.purple.shade100],
      [Colors.yellow.shade100, Colors.pink.shade100],
      [Colors.purple.shade100, Colors.blue.shade100],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Información',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Nunito',
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade200, Colors.blue.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Fondo con burbujas flotantes
          AnimatedBuilder(
            animation: _bubblesController,
            builder: (context, child) {
              final bubbles = List.generate(12, (index) {
                final animationValue =
                    (_bubblesController.value + index * 0.1) % 1;
                final top = MediaQuery.of(context).size.height *
                    (1 - animationValue);
                final left = 40.0 * index % MediaQuery.of(context).size.width;

                return Positioned(
                  top: top,
                  left: left,
                  child: Container(
                    width: 20 + (index % 3) * 10,
                    height: 20 + (index % 3) * 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: [
                        Colors.pink.shade100,
                        Colors.blue.shade100,
                        Colors.yellow.shade100,
                        Colors.purple.shade100,
                      ][index % 4].withOpacity(0.6),
                    ),
                  ),
                );
              });

              return Stack(children: bubbles);
            },
          ),

          // Contenido
          SafeArea(
            child: ListView.builder(
              itemCount: _titles.length,
              itemBuilder: (context, index) {
                return _buildCustomCard(
                  context,
                  _imageUrls[index],
                  _titles[index],
                  _icons[index],
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => _pages[index]),
                    );
                  },
                  gradientColors: pastelPalettes[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}














