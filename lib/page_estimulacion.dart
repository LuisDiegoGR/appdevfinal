import 'package:appdevfinal/Gride.dart';
import 'package:appdevfinal/informacion1.dart';
import 'package:flutter/material.dart';

class PageEstimulacion extends StatefulWidget {
  const PageEstimulacion({super.key});

  @override
  _PageEstimulacionState createState() => _PageEstimulacionState();
}

class _PageEstimulacionState extends State<PageEstimulacion> with SingleTickerProviderStateMixin {
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
              const SizedBox(height: 80),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Tecnicas de valoracion inicial en el recien nacido',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 23),
                                  SlideTransition(
                      position: _offsetAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: const Text(
                          'Esta escala se aplica al recién nacido al minuto de haber nacido y a los 5 minutos, evaluando la frecuencia cardiaca, respiración, reflejos, tono muscular y color. De esta manera se cuantifican los signos de depresión neonatal.',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
              const SizedBox(height: 23),
                                  SlideTransition(
                      position: _offsetAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: const Text(
                          'Un puntaje  de 0 a 3 en a los 5 minutos se correlaciona con mortalidad neonatal en grandes poblaciones sin predecir disfunción neurológica.',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
              const SizedBox(height: 23),
              SlideTransition(
                      position: _offsetAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: const Text(
                          'Un bajo puntaje de APGAR a los minutos conlleva mayor riesgo de parálisis cerebral, Si el puntaje a los 5 minutos es de 7 o más, es poco probable que la hipoxia isquémica periparto causara encefalopatía neonatal.',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
              SizedBox(height: 40),
              RawMaterialButton(
                fillColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Overlapped()),
                  );
                },
                child: const Text(
                  'Evaluacion',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 150),
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
              MaterialPageRoute(builder: (context) => const Informacion1()),
            );
              },
            ),
          ),
      ],
    ),
    );
  }
}

void main() => runApp(const MaterialApp(
  home: PageEstimulacion(),
));


//Un bajo puntaje de APGAR a los minutos conlleva mayor riesgo de parálisis cerebral, Si el puntaje a los 5 minutos es de 7 o más, es poco probable que la hipoxia isquémica periparto causara encefalopatía neonatal
//Un puntaje  de 0 a 3 en a los 5 minutos se correlaciona con mortalidad neonatal en grandes poblaciones sin predecir disfunción neurológica.
//Esta escala se aplica al recién nacido al minuto de haber nacido y a los 5 minutos, evaluando la frecuencia cardiaca, respiración, reflejos, tono muscular y color. De esta manera se cuantifican los signos de depresión neonatal.