import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'page_alteraciones.dart';
import 'page_embarazo.dart';
import 'page_estimulacion.dart';
import 'page_foro.dart';

class Informacion1 extends StatefulWidget {
  const Informacion1({super.key});

  @override
  State<Informacion1> createState() => _Informacion1State();
}

class _Informacion1State extends State<Informacion1> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final List<String> _imageUrls = [
    'assets/images/estimulacion.png',
    'assets/images/embarazo.png',
    'assets/images/niña.png',
    'assets/images/foro.png',
  ];

  final List<String> _titles = [
    'Estimulación Temprana',
    'Embarazo de Alto Riesgo',
    'Alteraciones en el Desarrollo',
    'Foro de Discusión',
  ];

  final List<Widget> _pages = [
    const PageEstimulacion(),
    PageEmbarazo(),
    const PageAlteraciones(),
    PageForo(),
  ];

  double _currentPage = 0.0;
  bool _showText = true;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
        _showText = _currentPage < _imageUrls.length - 1;
      });
    });

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildImage(String imagePath, double pageOffset) {
    return Transform.translate(
      offset: Offset(-pageOffset * 100, 0),
      child: Opacity(
        opacity: (1 - pageOffset).clamp(0.0, 1.0),
        child: Image.asset(
          imagePath,
          width: double.infinity,
          height: 400,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildAnimatedButton(Function() onPressed) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF33C6A4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Comenzar',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedText() {
    return AnimatedOpacity(
      opacity: _showText ? 1.0 : 0.0,
      duration: const Duration(seconds: 2),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Desliza para ver más',
            style: TextStyle(
              color: Color.fromARGB(255, 139, 137, 137),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black54,
          ),
        ],
      ),
    ).animate().scale(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _imageUrls.length,
            itemBuilder: (context, index) {
              final image = _imageUrls[index];
              final title = _titles[index].toUpperCase();
              final pageOffset = (index - _currentPage).abs();

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50), // Espacio para mover el texto hacia arriba
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20), // Espacio adicional entre el texto y la imagen
                    _buildImage(
                      image,
                      pageOffset,
                    ),
                    const SizedBox(height: 30),
                    _buildAnimatedButton(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => _pages[index]),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: _buildAnimatedText(),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(const MaterialApp(
  home: Informacion1(),
));
