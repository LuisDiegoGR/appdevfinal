import 'package:appdevfinal/informacion1.dart';
import 'package:appdevfinal/page_emb_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PageEmbarazo extends StatefulWidget {
  @override
  _PageEmbarazoState createState() => _PageEmbarazoState();
}

class _PageEmbarazoState extends State<PageEmbarazo> with SingleTickerProviderStateMixin {
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
      begin: Offset(0.0, 1.0),
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
     appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Informacion1()),
            );
          },
        ),
        title: const Text('Prueba de scroll'),
        shadowColor: Colors.grey,
        scrolledUnderElevation: 10.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
<<<<<<< HEAD
              const Text(
                'Antes del Embarazo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 16),
              const Text(
                'Es derecho de cada individuo el poder decidir acerca del número de hijos y el momento de su vida en que decida tenerlos. Se hace necesario informarse al respecto.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text(
                'Potenciales riesgos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Biologicos\n'
                '• Sociodemográficos\n'
                '• Economicos',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                'El embarazo es un hecho trascendental en el ámbito familiar y principalmente en la vida de la mujer, ya que representaran una carga emocional y de cambios biológicos, los cuales por si solos representaran un riesgo tanto para la madre como para el bebé.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                'Es importante identificar los diferentes factores de riesgo antes (Preconcepcionales), durante (obstétricos) o después de la gestación (Perinatales) que aumentan la probabilidad de complicaciones pongan en riesgo la vida de la madre tanto como para el hijo, así como en su posterior desarrollo psicomotor',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 35),
              const Text(
                'La acción que cobra relevancia es realizar la detección oportuna de estas condiciones que pueden poner en riesgo el embarazo. ',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 11),
              const Text(
                'Causas de muerte materna',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 20.4,
                        title: '20.4%',
                        color: Colors.blue,
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      PieChartSectionData(
                        value: 20.2,
                        title: '20.2%',
                        color: Colors.red,
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      PieChartSectionData(
                        value: 8.7,
                        title: '8.7%',
                        color: Colors.green,
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
=======
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Antes del Embarazo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Es derecho de cada individuo el poder decidir acerca del número de hijos y el momento de su vida en que decida tenerlos. Se hace necesario informarse al respecto.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Potenciales riesgos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 8),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    '• Biologicos\n'
                    '• Sociodemográficos\n'
                    '• Economicos',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'El embarazo es un hecho trascendental en el ámbito familiar y principalmente en la vida de la mujer, ya que representaran una carga emocional y de cambios biológicos, los cuales por si solos representaran un riesgo tanto para la madre como para el bebé.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Es importante identificar los diferentes factores de riesgo antes (Preconcepcionales), durante (obstétricos) o después de la gestación (Perinatales) que aumentan la probabilidad de complicaciones pongan en riesgo la vida de la madre tanto como para el hijo, así como en su posterior desarrollo psicomotor',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              SizedBox(height: 35),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'La acción que cobra relevancia es realizar la detección oportuna de estas condiciones que pueden poner en riesgo el embarazo. ',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              SizedBox(height: 11),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Causas de muerte materna',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: 20.4,
                            title: '20.4%',
                            color: Colors.blue,
                            radius: 50,
                            titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          PieChartSectionData(
                            value: 20.2,
                            title: '20.2%',
                            color: Colors.red,
                            radius: 50,
                            titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          PieChartSectionData(
                            value: 8.7,
                            title: '8.7%',
                            color: Colors.green,
                            radius: 50,
                            titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.blue),
                        title: Text('Hemorragia obsterica'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.red),
                        title: Text('Enfermedad hipertensiva'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.green),
                        title: Text('Aborto'),
>>>>>>> 8321d6e2842c859f38c9ef384d151683c39ce4eb
                      ),
                    ],
                  ),
                ),
              ),
<<<<<<< HEAD
              const SizedBox(height: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.blue),
                    title: Text('Hemorragia obsterica'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.red),
                    title: Text('Enfermedad hipertensiva'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.green),
                    title: Text('Aborto'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Causas de muerte perinatal con mas de 500mg y del recien nacido hasta los 7 dias',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                '• Asfixia perinatal\n'
                '• Infecciones\n'
                '• Defectos congenitos\n'
                '• Prematuridad',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 35),
              RawMaterialButton(
              fillColor: Colors.green,
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const PageEmb2()),
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
            const SizedBox(height: 50),
=======
              SizedBox(height: 20),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Causas de muerte perinatal con mas de 500mg y del recien nacido hasta los 7 dias',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    '• Asfixia perinatal\n'
                    '• Infecciones\n'
                    '• Defectos congenitos\n'
                    '• Prematuridad',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 35),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: RawMaterialButton(
                    fillColor: Colors.green,
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => PageEmb2()),
                      );
                    },
                    child: Text(
                      'Continuar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
>>>>>>> 8321d6e2842c859f38c9ef384d151683c39ce4eb
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: PageEmbarazo(),
));
