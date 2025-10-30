import 'package:flutter/material.dart';

class ConfirmacionPage extends StatefulWidget {
  @override
  _ConfirmacionPageState createState() => _ConfirmacionPageState();
}

class _ConfirmacionPageState extends State<ConfirmacionPage> {
  Widget _buildOptionButton({
    required String text,
    required List<Color> colors,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: colors.last.withOpacity(0.5),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 36),
              SizedBox(width: 16),
              Text(
                text,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo moderno y vistoso
      backgroundColor: Color(0xFFE3F2FD), // Azul muy suave
      appBar: AppBar(
        title: const Text('Confirmación'),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 6,
        shadowColor: Colors.deepPurpleAccent.withOpacity(0.4),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Si en la encuesta anterior tu bebé salió:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                SizedBox(height: 40),
                _buildOptionButton(
                  text: 'Excelente',
                  colors: [Colors.green.shade400, Colors.lightGreenAccent.shade400],
                  icon: Icons.emoji_emotions_outlined,
                  onPressed: () {
                    Navigator.of(context).pop({'result': 'excelente'});
                  },
                ),
                _buildOptionButton(
                  text: 'Atención',
                  colors: [Colors.orangeAccent.shade400, Colors.deepOrange.shade400],
                  icon: Icons.warning_amber_outlined,
                  onPressed: () {
                    Navigator.of(context).pop({'result': 'atencion'});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

