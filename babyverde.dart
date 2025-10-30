import 'package:flutter/material.dart';
import 'calendario_mes4.dart';
import 'calendario_mes5.dart';
import 'calendario_mes6.dart';

class BabyVerdePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendarios Bebé 💚',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.green.shade300,
        centerTitle: true,
      ),
      backgroundColor: Colors.pink.shade50, // Fondo rosado suave
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BotonCalendario(
              texto: 'Calendario Mes 4',
              ruta: CalendarioMes4Page(),
              imagen: 'assets/images/bebe_mes4.png',
            ),
            SizedBox(height: 40), // Mayor separación entre botones
            BotonCalendario(
              texto: 'Calendario Mes 5',
              ruta: CalendarioMes5Page(),
              imagen: 'assets/images/bebe_mes5.png',
            ),
            SizedBox(height: 40),
            BotonCalendario(
              texto: 'Calendario Mes 6',
              ruta: CalendarioMes6Page(),
              imagen: 'assets/images/bebe_mes6.png',
            ),
          ],
        ),
      ),
    );
  }
}

class BotonCalendario extends StatefulWidget {
  final String texto;
  final Widget ruta;
  final String imagen;

  const BotonCalendario({
    required this.texto,
    required this.ruta,
    required this.imagen,
  });

  @override
  _BotonCalendarioState createState() => _BotonCalendarioState();
}

class _BotonCalendarioState extends State<BotonCalendario>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.reverse(),
      onTapUp: (_) {
        _controller.forward();
        Future.delayed(Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.ruta),
          );
        });
      },
      onTapCancel: () => _controller.forward(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Stack(
          clipBehavior: Clip.none, // Permite que la imagen sobresalga
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding: EdgeInsets.only(left: 100, right: 16), // 🔥 MOVEMOS EL TEXTO MÁS A LA DERECHA 🔥
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.texto,
                    style: TextStyle(
                      fontSize: 22, // Texto más grande
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => widget.ruta),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    child: Text('Ver información'),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -40, // Hace que la imagen sobresalga aún más
              left: -20, // Ajuste de posición
              child: Image.asset(
                widget.imagen,
                width: 130, // Imagen más grande para un mejor efecto
              ),
            ),
          ],
        ),
      ),
    );
  }
}










































