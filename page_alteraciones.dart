import 'package:appdevfinal/Rincon_bebe.dart';
import 'package:appdevfinal/informacion1.dart';
import 'package:flutter/material.dart';

class PageAlteraciones extends StatefulWidget {
  const PageAlteraciones({super.key});

  @override
  State<PageAlteraciones> createState() => _PageAlteracionesState();
}

class _PageAlteracionesState extends State<PageAlteraciones> with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Informacion1()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'ALTERACIONES DE LA SUCCIÓN - DEGLUCIÓN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
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
                          text: 'Durante la alimentación,',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' la deglución es un proceso involuntario y reflejo que está presente desde el nacimiento. Para que esta se lleve a cabo de manera adecuada, es necesaria la integración de una gran variedad de estructuras que participan en el proceso:',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    '• Óseas.\n'
                    '• Musculares.\n'
                    '• Nerviosas.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
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
                          text: 'Que canalizan las sensaciones y',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' los movimientos con la deglución. Consta de tres fases, coordinadas entre ellas y con la respiración: fase oral, fase faríngea y fase esofágica.',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: RawMaterialButton(
                    fillColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const EvaluaTemp()),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}