import 'package:appdevfinal/page_alteraciones.dart';
import 'package:appdevfinal/page_embarazo.dart';
import 'package:appdevfinal/page_estimulacion.dart';
import 'package:appdevfinal/page_foro.dart';
import 'package:flutter/material.dart';

class Informacion1 extends StatefulWidget {
  const Informacion1({Key? key}) : super(key: key);

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
    PageEstimulacion(),
    PageEmbarazo(),
    PageAlteraciones(),
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
        _showText = _currentPage < (_imageUrls.length - 1);
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

  Widget _buildImage(String imagePath, {double width = 300, double height = 300, double left = 0, double right = 0}) {
    return Container(
      margin: EdgeInsets.only(left: left, right: right),
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
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
              backgroundColor: Color.fromRGBO(20, 86, 71, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
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
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: AnimatedOpacity(
        opacity: _showText ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: Row(
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
              Icons.arrow_forward,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información'),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _imageUrls.length,
            itemBuilder: (context, index) {
              final image = _imageUrls[index];
              final title = _titles[index].toUpperCase(); // Convertir a mayúsculas
              final pageOffset = (index - _currentPage).abs();
              final scale = 1 - (pageOffset * 0.3).clamp(0.0, 0.3);

              return Center(
                child: Transform.scale(
                  scale: scale,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      _buildImage(
                        image,
                        width: 300,
                        height: 300,
                        left: 0,
                        right: 0,
                      ),
                      SizedBox(height: 30),
                      _buildAnimatedButton(() {
                        // Navegar a la página correspondiente
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => _pages[index]),
                        );
                      }),
                    ],
                  ),
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
