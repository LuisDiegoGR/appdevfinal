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
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      width: 350,
                      height: 150, // Reducimos la altura a 150
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Estimulación',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.only(left: 40),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 128,
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción del botón
                      },
                      child: Text(
                        'Empezar',
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
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/estimulacion.png',
                      width: 130,
                      height: 290,
                      alignment: Alignment.centerRight,
                    ),
                    padding: EdgeInsets.only(left: 26),
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Segundo contenedor con imagen delante
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      width: 350,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Embarazo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 128,
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción del botón
                      },
                      child: Text(
                        'Empezar',
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
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/embarazo.png',
                      width: 130,
                      height: 290,
                      alignment: Alignment.centerRight,
                    ),
                    padding: EdgeInsets.only(left: 26),
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Tercer contenedor con imagen delante
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      width: 350,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Niña',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 128,
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción del botón
                      },
                      child: Text(
                        'Empezar',
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
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/niña.png',
                      width: 130,
                      height: 290,
                      alignment: Alignment.centerRight,
                    ),
                    padding: EdgeInsets.only(left: 26),
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Cuarto contenedor con imagen delante
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      width: 350,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Foro',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 128,
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción del botón
                      },
                      child: Text(
                        'Empezar',
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
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/foro.png',
                      width: 130,
                      height: 290,
                      alignment: Alignment.centerRight,
                    ),
                    padding: EdgeInsets.only(left: 26),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
