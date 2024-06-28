import 'package:appdevfinal/page_emb_3.dart';
import 'package:appdevfinal/page_embarazo.dart';
import 'package:flutter/material.dart';

class PageEmb2 extends StatefulWidget {
  const PageEmb2({super.key});

  @override
  State<PageEmb2> createState() => _PageEmb2State();
}

class _PageEmb2State extends State<PageEmb2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
     Container(
           decoration: const BoxDecoration(
              color: Colors.white,
            ),
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Riesgos preconcepcionales',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Antecedentes de embarazos previos',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' Abortos previos, muertes fetales y neonatales, partos prematuros, bajo peso al nacer, enfermedades hipertensivas del embarazo, periodo intergenésico corto < de 2 años, diabetes gestacional',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Características propias de la madre',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Edad materna: ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Embarazo adolescente (10 a 19 años) y mujeres mayores de 35 años',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Antecedentes patológicos: ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Hipertensión pregestacional, Diabetes, anemia, tuberculosis, discapacidad intelectual, enfermedades psiquiátricas, estado nutricional, infecciones de transmisión sexual (VIH, Sifilis, gonorrea, hepatitis), consumo de tabaco, drogas',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 21),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Durante ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'este periodo que la mujer no está embarazada, se han de identificar los diferentes factores que pueden poner en riesgo su vida y la del producto durante el embarazo. ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'En este momento se tienen que realizar acciones preventivas como:',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    '• Corregir hábitos alimenticios para llevar a un adecuado estado nutricional.\n'
                    '• Control de enfermedades crónicas y adicciones. \n'
                    '• Tamizaje para Infecciones de transmisión sexual.\n'
                    '• Aplicar vacunas (Td, Sarampion-Rubeola). \n'
                    '• Realizar citología vaginal.',
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Riesgo obsterico',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    '• Embarazo múltiple.\n'
                    '• Diabetes gestacional. \n'
                    '• Preeclamsia/eclampsia.\n'
                    '• Infecciones de vías urinarias / Cervicovaginitis. \n'
                    '• Ruptura prematura de membranas .\n'
                    '• Complicaciones obstétricas (Hemorragias, placenta previa, acretismo placentario, ruptura uterina).',
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: RawMaterialButton(
                    fillColor: Colors.black,
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const PageEmb3()),
                      );
                    },
                    child: const Text(
                      'Continuar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      ),
      Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PageEmbarazo())
            );
              },
            ),
          ),
        ],
      ),
    );
  }
}


