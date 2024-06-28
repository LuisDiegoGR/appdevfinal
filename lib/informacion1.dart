import 'package:flutter/material.dart';

import 'InicioApp.dart';
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

  late AnimationController _animationController;
  late Animation<Offset> _imageAnimation1;
  late Animation<Offset> _imageAnimation2;
  late Animation<Offset> _imageAnimation3;
  late Animation<Offset> _imageAnimation4;

  late Animation<Offset> _containerAnimation1;
  late Animation<Offset> _containerAnimation2;
  late Animation<Offset> _containerAnimation3;
  late Animation<Offset> _containerAnimation4;

  late Animation<Offset> _textAnimation1;
  late Animation<Offset> _textAnimation2;
  late Animation<Offset> _textAnimation3;
  late Animation<Offset> _textAnimation4;

  late Animation<Offset> _buttonAnimation1;
  late Animation<Offset> _buttonAnimation2;
  late Animation<Offset> _buttonAnimation3;
  late Animation<Offset> _buttonAnimation4;

  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _imageAnimation1 = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(_animationController);
    _imageAnimation2 = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(_animationController);
    _imageAnimation3 = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(_animationController);
    _imageAnimation4 = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(_animationController);

    _containerAnimation1 = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(_animationController);
    _containerAnimation2 = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(_animationController);
    _containerAnimation3 = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(_animationController);
    _containerAnimation4 = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(_animationController);

    _textAnimation1 = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(_animationController);
    _textAnimation2 = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(_animationController);
    _textAnimation3 = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(_animationController);
    _textAnimation4 = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(_animationController);

    _buttonAnimation1 = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(_animationController);
    _buttonAnimation2 = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(_animationController);
    _buttonAnimation3 = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(_animationController);
    _buttonAnimation4 = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(_animationController);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildImage(String imagePath, double top, double left, Animation<Offset> animation) {
    return Positioned(
      top: top,
      left: left,
      child: SlideTransition(
        position: animation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            width: 250,
            height: 250,
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomContainer(
    BuildContext context,
    String imagePath,
    String text,
    double imageTop,
    double imageLeft,
    double containerTop,
    double containerLeft,
    double textOffsetX,
    double textOffsetY,
    double buttonOffsetX,
    double buttonOffsetY,
    Function() onPressed,
    Animation<Offset> imageAnimation,
    Animation<Offset> containerAnimation,
    Animation<Offset> textAnimation,
    Animation<Offset> buttonAnimation,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Container(
        width: double.infinity,
        height: 190, // Ajusta el alto del contenedor según sea necesario
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: containerTop,
              left: containerLeft,
              child: SlideTransition(
                position: containerAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Transform.translate(
                          offset: Offset(textOffsetX, textOffsetY),
                          child: SlideTransition(
                            position: textAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: Text(
                                text,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Transform.translate(
                          offset: Offset(buttonOffsetX, buttonOffsetY),
                          child: SlideTransition(
                            position: buttonAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: ElevatedButton(
                                onPressed: onPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                ),
                                child: const Text(
                                  'Ver información',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _buildImage(imagePath, imageTop, imageLeft, imageAnimation),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const InicioApp()),
        );
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildCustomContainer(
                    context,
                    _imageUrls[0],
                    _titles[0],
                    10, // imageTop
                    -30, // imageLeft
                    80, // containerTop
                    16, // containerLeft
                    75, // textOffsetX
                    -20, // textOffsetY
                    75, // buttonOffsetX
                    -25, // buttonOffsetY
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => _pages[0]),
                      );
                    },
                    _imageAnimation1,
                    _containerAnimation1,
                    _textAnimation1,
                    _buttonAnimation1,
                  ),
                  _buildCustomContainer(
                    context,
                    _imageUrls[1],
                    _titles[1],
                    20, // imageTop
                    240, // imageLeft
                    80, // containerTop
                    -16, // containerLeft
                    -50, // textOffsetX
                    -20, // textOffsetY
                    -55, // buttonOffsetX
                    -25, // buttonOffsetY
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => _pages[1]),
                      );
                    },
                    _imageAnimation2,
                    _containerAnimation2,
                    _textAnimation2,
                    _buttonAnimation2,
                  ),
                  _buildCustomContainer(
                    context,
                    _imageUrls[2],
                    _titles[2],
                    10, // imageTop
                    -10, // imageLeft
                    80, // containerTop
                    16, // containerLeft
                    50, // textOffsetX
                    -15, // textOffsetY
                    60, // buttonOffsetX
                    -25, // buttonOffsetY
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => _pages[2]),
                      );
                    },
                    _imageAnimation3,
                    _containerAnimation3,
                    _textAnimation3,
                    _buttonAnimation3,
                  ),
                  _buildCustomContainer(
                    context,
                    _imageUrls[3],
                    _titles[3],
                    5, // imageTop
                    165, // imageLeft
                    80, // containerTop
                    -16, // containerLeft
                    -80, // textOffsetX
                    -20, // textOffsetY
                    -80, // buttonOffsetX
                    -25, // buttonOffsetY
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => _pages[3]),
                      );
                    },
                    _imageAnimation4,
                    _containerAnimation4,
                    _textAnimation4,
                    _buttonAnimation4,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const InicioApp()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(
  home: Informacion1(),
));
