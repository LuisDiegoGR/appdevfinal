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

class _Informacion1State extends State<Informacion1> {
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

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
        _showText = _currentPage < (_imageUrls.length - 1);
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información'),
      ),
      body: Center(
        child: PageView.builder(
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
                      width: 300,   // Puedes ajustar el ancho aquí
                      height: 300,  // Puedes ajustar la altura aquí
                      left: 0,      // Puedes ajustar el margen izquierdo aquí
                      right: 0,     // Puedes ajustar el margen derecho aquí
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 200, // Ancho moderado del botón
                      child: ElevatedButton(
                        onPressed: () {
                          // Navegar a la página correspondiente
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => _pages[index]),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(20, 86, 71, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          'IR',
                          style: TextStyle(
                            fontSize: 18, 
                            color: Colors.white, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
