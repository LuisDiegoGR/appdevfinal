import 'package:flutter/material.dart';

class PageForo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        title: const Text('Foro de Discusión'),
      ),
=======
>>>>>>> 8321d6e2842c859f38c9ef384d151683c39ce4eb
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Foro de Discusión',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/mante.png',
            width: 400, 
            height: 400, 
          ),
          const SizedBox(height: 20),
          AnimatedText(),
        ],
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween<double>(begin: 18, end: 24).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
<<<<<<< HEAD
Widget build(BuildContext context) {
  return AnimatedBuilder(
    animation: _animation,
    builder: (context, child) {
      return Text(
        '¡Disculpe las molestias, estamos en mantenimiento!',
        style: TextStyle(
          fontSize: _animation.value,
          color: const Color.fromARGB(255, 176, 38, 28),
          fontWeight: FontWeight.bold, 
        ),
        textAlign: TextAlign.center,
      );
    },
  );
}}
=======
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          children: [
            Text(
              '¡Disculpe las molestias!',
              style: TextStyle(
                fontSize: _animation.value,
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold, // Agregar negritas al texto
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Estamos realizando tareas de mantenimiento para mejorar su experiencia. Por favor, vuelva más tarde.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Icon(
              Icons.construction,
              color: Colors.orange.shade700,
              size: 50,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Lógica para el botón, como regresar a una pantalla anterior
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Regresar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PageForo(),
  ));
}
>>>>>>> 8321d6e2842c859f38c9ef384d151683c39ce4eb
