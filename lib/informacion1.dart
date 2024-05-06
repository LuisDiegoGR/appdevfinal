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

  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
              final title = _titles[index];
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
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      Image.asset(
                        image,
                        width: 300,
                        height: 300,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          // Acción del botón
                        },
                        child: Text(
                          'Ver Información',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: AnimatedOpacity(
              opacity: _currentPage < (_imageUrls.length - 1) ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Row(
                children: [
                  Icon(Icons.arrow_forward, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    'Desliza para ver más',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
