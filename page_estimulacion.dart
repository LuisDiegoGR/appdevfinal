import 'dart:math';
import 'package:flutter/material.dart';
import 'actividades.dart';
import 'actividades2.dart';
import 'encuestaPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageEstimulacion extends StatefulWidget {
  const PageEstimulacion({super.key});

  @override
  State<PageEstimulacion> createState() => _PageEstimulacionState();
}

class _PageEstimulacionState extends State<PageEstimulacion>
    with SingleTickerProviderStateMixin {
  bool desbloquearPlan = false;
  bool desbloquearAvanzadas = false;
  bool encuestaCompletada = false; // <-- Nueva variable

  late AnimationController _controller;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _loadPreferences();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat();
    _floatingAnimation = Tween<double>(begin: 0, end: 15).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // --- Cargar preferencias guardadas ---
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      desbloquearPlan = prefs.getBool('desbloquearPlan') ?? false;
      desbloquearAvanzadas = prefs.getBool('desbloquearAvanzadas') ?? false;
      encuestaCompletada = prefs.getBool('encuestaCompletada') ?? false;
    });
  }

  // --- Guardar preferencias ---
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('desbloquearPlan', desbloquearPlan);
    await prefs.setBool('desbloquearAvanzadas', desbloquearAvanzadas);
    await prefs.setBool('encuestaCompletada', encuestaCompletada);
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -_floatingAnimation.value),
                child: child,
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: RotationTransition(
                    turns: Tween<double>(begin: 0, end: 1).animate(_controller),
                    child: CustomPaint(
                      painter: RainbowPainter(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 400,
                  child: CustomPaint(
                    painter: StarPainter(_controller),
                  ),
                ),
                Container(
                  width: 280,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFF1F9),
                        Color(0xFFFFE0F7),
                        Color(0xFFFFD6F0)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.pinkAccent,
                            width: 5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pinkAccent.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/gifs/Baby_saludando.gif',
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '🎉 ¡BIENVENIDO! 🎉\n\nAquí podrás desbloquear el plan de actividades para que tu bebé y tú empiecen una serie de aventuras. ¡Mucha suerte!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: Colors.pinkAccent,
                          elevation: 10,
                          shadowColor: Colors.pinkAccent.withOpacity(0.6),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text(
                          '¡Comenzar!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBE8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD17BDB),
        title: const Text(
          'Valoración Inicial del Recién Nacido',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: encuestaCompletada
                    ? null // <-- Botón bloqueado si ya completó
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EncuestaPage(),
                          ),
                        ).then((_) => _loadPreferences());
                      },
                icon: const Icon(Icons.assignment),
                label: const Text('Ingresa a la Encuesta'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: encuestaCompletada
                      ? Colors.grey // <-- Color gris cuando está bloqueado
                      : const Color(0xFFE859CF),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildActivityCard(
              context,
              title: 'ACTIVIDADES DE EMBARAZO SIN RIESGO',
              subtitle:
                  'Accede a actividades esenciales para los primeros meses de vida.',
              icon: Icons.shield,
              color: const Color(0xFF4DA8DA),
              isUnlocked: desbloquearPlan,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActividadesPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildActivityCard(
              context,
              title: 'ACTIVIDADES DE EMBARAZO DE ALTO RIESGO',
              subtitle:
                  'Accede a estimulación avanzada para bebés en crecimiento.',
              icon: Icons.warning_amber_rounded,
              color: const Color(0xFFFFC4E1),
              isUnlocked: desbloquearAvanzadas,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Actividades2Page()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 6,
      color: const Color(0xFFEBDDFB),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '📋 Técnicas de valoración inicial:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 16),
            Text(
              'Esta escala se aplica al recién nacido al minuto y a los 5 minutos de haber nacido, evaluando la frecuencia cardiaca, respiración, reflejos, tono muscular y color.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 12),
            Text(
              'Un puntaje de 0 a 3 a los 5 minutos se correlaciona con mayor riesgo de mortalidad neonatal.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 12),
            Text(
              'Se recomienda evaluación continua durante los primeros meses para asegurar un desarrollo adecuado.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 12),
            Text(
              '👶 Actividades sugeridas: ejercicios de estimulación, monitoreo del desarrollo y comunicación con el pediatra.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isUnlocked,
    required Function onTap,
  }) {
    final Color displayColor = isUnlocked ? color : color.withOpacity(0.5);

    return GestureDetector(
      onTap: isUnlocked ? () => onTap() : null,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: displayColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

// Pintor de arco iris girando
class RainbowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = SweepGradient(
      colors: [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.indigo,
        Colors.purple,
        Colors.red,
      ],
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2 - 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Pintor de estrellas cayendo
class StarPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random = Random();
  final int starCount = 50;
  late List<Offset> positions;
  late List<double> sizes;

  StarPainter(this.animation) {
    positions = List.generate(
      starCount,
      (index) => Offset(random.nextDouble() * 300, random.nextDouble() * 400),
    );
    sizes = List.generate(starCount, (index) => 2 + random.nextDouble() * 4);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.yellowAccent;
    for (int i = 0; i < starCount; i++) {
      double y = (positions[i].dy + animation.value * 50) % size.height;
      canvas.drawCircle(Offset(positions[i].dx, y), sizes[i], paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) => true;
}
