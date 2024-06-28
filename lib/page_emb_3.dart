import 'package:appdevfinal/page_emb_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PageEmb3 extends StatefulWidget {
  const PageEmb3({super.key});

  @override
  State<PageEmb3> createState() => _PageEmb3State();
}

class _PageEmb3State extends State<PageEmb3> with SingleTickerProviderStateMixin {
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
      body:  Stack(
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
              const SizedBox(height: 35),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Factores perinatales',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto'
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
                    '• Estrato socioeconómico bajo (Signos neurológicos blandos desaparecen más tardíamente.\n'
                    '• Bajo peso al nacer \n'
                    '• Prematures \n'
                    '• Hipoxia perinatal',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto'
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                          text: 'Puede condicionar',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: ' la aparición de una encefalopatía dentro de las primeras 6-24 hrs, denominándosele así “Encefalopatía hipóxico-isquémica” y se divide en 3 grados',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.green),
                        title: Text('Leve: Irritabilidad, hipertonía leve y succión débil.'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.yellow),
                        title: Text('Moderada: Letargia e hipotonía y pueden aparecer convulsiones focales o generalizadas.'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.red),
                        title: Text('Grave: Estado comatoso con hipotonía marcada y ausencia total del reflejo de succión.'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Hipoxia',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 22),
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
                            value: 85.0,
                            title: '85%',
                            color: Colors.blue,
                            radius: 50,
                            titleStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            value: 10.0,
                            title: '10%',
                            color: Colors.red,
                            radius: 50,
                            titleStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            value: 5.0,
                            title: '5%',
                            color: Colors.green,
                            radius: 50,
                            titleStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.blue),
                        title: Text('Durante el parto'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.red),
                        title: Text('Periodo neonatal'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle, color: Colors.green),
                        title: Text('Inicio del trabajo de parto'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Causas relacionadas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    '• Interrupción de la circulación umbilical por compresión, prolapso o accidentes del cordón, circulares irreductibles. \n'
                    '\n'
                    '• Desprendimiento prematuro de placenta, placenta previa, hipotensión materna y alteraciones de la contractibilidad uterina.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                          text: 'El periodo perinatal',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: ' es la etapa más vulnerable del ser humano ya que se presentan adaptaciones de órganos y sistemas durante la transición de la vida intrauterina a la extrauterina. ',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                          text: 'La capacidad del ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'recién nacido para comenzar su vida extrauterina desarrollando todo su potencial genético y posterior crecimiento físico e intelectual, depende principalmente de su posibilidad para superar diversas situaciones de peligro en la gestación y el parto. ',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
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
              MaterialPageRoute(builder: (context) => const PageEmb2())
            );
              },
            ),
          ),
      ],
      ),
    );
  }
}
