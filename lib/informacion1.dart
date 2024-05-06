import 'package:flutter/material.dart';

class Informacion1 extends StatelessWidget {
  const Informacion1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Primer contenedor con imagen delante
              _buildContainer(
                title: 'Estimulación Temprana',
                image: 'assets/images/estimulacion.png',
                context: context,
              ),
              SizedBox(height: 30),
              // Segundo contenedor con imagen delante
              _buildContainer(
                title: 'Embarazo de Alto Riesgo',
                image: 'assets/images/embarazo.png',
                context: context,
                alignRight: true,
              ),
              SizedBox(height: 30),
              // Tercer contenedor con imagen delante
              _buildContainer(
                title: 'Alteraciones en el Desarrollo',
                image: 'assets/images/niña.png',
                context: context,
              ),
              SizedBox(height: 30),
              // Cuarto contenedor con imagen delante
              _buildContainer(
                title: 'Foro de Discusión',
                image: 'assets/images/foro.png',
                context: context,
                alignRight: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer({
    required String title,
    required String image,
    required BuildContext context,
    bool alignRight = false,
  }) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            width: 350,
            height: 200, // Altura aumentada para que las imágenes sobresalgan un poco
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start, // Alineación del texto y el botón
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Acción del botón
                  },
                  child: Text(
                    'Ver Información',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 40),
          ),
        ),
        Positioned(
          top: 50,
          right: alignRight ? 0 : null,
          left: alignRight ? null : 0,
          child: Image.asset(
            image,
            width: 150, // Ancho aumentado para que las imágenes sobresalgan del rectángulo
            height: 180, // Altura aumentada para que las imágenes sobresalgan del rectángulo
            alignment: Alignment.centerRight,
          ),
        ),
      ],
    );
  }
}
