import 'dart:math';
import 'package:flutter/material.dart';
import 'page_emb_2.dart'; // <<--- Importa tu archivo de destino

class RuletaPage extends StatefulWidget {
  @override
  _RuletaPageState createState() => _RuletaPageState();
}

class _RuletaPageState extends State<RuletaPage>
    with SingleTickerProviderStateMixin {
  final categories = ['👶 Embarazo', '🤸 Ejercicio', '🌸 Bienestar'];

  final Map<String, List<Map<String, String>>> datos = {
    '👶 Embarazo': [
      {
        'text': 'Los partos de noche son más comunes debido a hormonas.',
        'image': 'assets/images/partosnoche.jpg'
      },
      {
        'text': 'El récord del bebé más pesado al nacer es de 10.2 kg.',
        'image': 'assets/images/beberecord.jpg'
      },
      {
        'text': 'El trabajo de parto puede durar pocas horas o más de un día.',
        'image': 'assets/images/trabajoparto.jpg'
      },
      {
        'text': 'Mantenerse hidratada ayuda a prevenir contracciones prematuras.',
        'image': 'assets/images/hidratar2.jpg'
      },
      {
        'text': 'Una dieta balanceada con ácido fólico ayuda al desarrollo del bebé.',
        'image': 'assets/images/dieta2.jpg'
      },
    ],
    '🤸 Ejercicio': [
      {
        'text':
            'Caminar diariamente mejora la circulación y mantiene activa a la madre.',
        'image': 'assets/images/caminar2.jpg'
      },
      {
        'text': 'El yoga prenatal reduce el estrés y fortalece músculos.',
        'image': 'assets/images/yoga2.jpg'
      },
      {
        'text': 'Nadar es un ejercicio de bajo impacto ideal en el embarazo.',
        'image': 'assets/images/nadar2.jpg'
      },
      {
        'text': 'Ejercicios de respiración ayudan a controlar el dolor durante el parto.',
        'image': 'assets/images/ejercicios2.jpg'
      },
      {
        'text': 'Estiramientos suaves previenen calambres y rigidez muscular.',
        'image': 'assets/images/estiramientos2.jpg'
      },
    ],
    '🌸 Bienestar': [
      {
        'text': 'La meditación reduce la ansiedad durante el embarazo.',
        'image': 'assets/images/meditacion2.jpg'
      },
      {
        'text': 'Dormir del lado izquierdo mejora la circulación al bebé.',
        'image': 'assets/images/ladoizq.jpg'
      },
      {
        'text': 'Los masajes prenatales alivian la tensión muscular.',
        'image': 'assets/images/masajes2.jpg'
      },
      {
        'text': 'Escuchar música relajante contribuye al bienestar emocional.',
        'image': 'assets/images/escucharmusic.jpg'
      },
      {
        'text': 'Tomar baños tibios ayuda a reducir el estrés y la fatiga.',
        'image': 'assets/images/bañostibios.jpg'
      },
    ],
  };

  String selectedCategory = '';
  Map<String, String> randomDato = {};
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isSpinning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _animation = Tween<double>(begin: 0, end: 8 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          selectRandomCategory();
          setState(() => isSpinning = false);
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void spinWheel() {
    if (isSpinning) return;
    setState(() => isSpinning = true);
    _controller.forward(from: 0);
  }

  void selectRandomCategory() {
    final randomIndex = Random().nextInt(categories.length);
    final category = categories[randomIndex];
    final randomList = (datos[category]!..shuffle());
    setState(() {
      selectedCategory = category;
      randomDato = randomList[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWideScreen = size.width > 800; // Umbral para PC
    final ruletaSize = min(size.width, size.height) * (isWideScreen ? 0.35 : 0.45);
    final titleFontSize = size.width * (isWideScreen ? 0.025 : 0.05);
    final textFontSize = size.width * (isWideScreen ? 0.018 : 0.045);
    final imageWidth = isWideScreen ? size.width * 0.4 : size.width * 0.8;
    final imageHeight = isWideScreen ? size.height * 0.5 : size.height * 0.35;

    // Ruleta con GestureDetector
    Widget ruleta = GestureDetector(
      onTap: spinWheel,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow.shade600,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2),
              ),
              padding: EdgeInsets.all(4),
              child: Icon(Icons.arrow_drop_down, size: 36, color: Colors.white),
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animation.value,
                child: child,
              );
            },
            child: Container(
              height: ruletaSize,
              width: ruletaSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3))
                ],
              ),
              child: CustomPaint(painter: RuletaPainter(categories)),
            ),
          ),
        ],
      ),
    );

    Widget imagenYTexto = selectedCategory.isNotEmpty
        ? Card(
            color: Colors.pink.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 6,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Text(
                    selectedCategory,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ComicSans',
                      color: Colors.pink.shade400,
                    ),
                  ),
                  SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      randomDato['image']!,
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    randomDato['text']!,
                    style: TextStyle(
                      fontSize: textFontSize,
                      height: 1.4,
                      fontFamily: 'ComicSans',
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PageEmb2()),
            );
          },
        ),
        title: Text(
          '🎡 Ruleta Mágica',
          style: TextStyle(fontFamily: 'ComicSans', fontSize: titleFontSize),
        ),
        backgroundColor: Colors.pink.shade300,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade50, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isWideScreen
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ruleta,
                  SizedBox(width: 50),
                  Expanded(child: SingleChildScrollView(child: imagenYTexto)),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      '✨ ¡Gira para descubrir un secreto! ✨',
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ComicSans',
                        color: Colors.purple.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ruleta,
                    SizedBox(height: 20),
                    imagenYTexto,
                    SizedBox(height: 80),
                  ],
                ),
              ),
      ),
    );
  }
}

/// 🎨 Ruleta infantil con colores pastel y emojis
class RuletaPainter extends CustomPainter {
  final List<String> categories;
  RuletaPainter(this.categories);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final sweepAngle = 2 * pi / categories.length;
    final colors = [
      Colors.pink.shade200,
      Colors.blue.shade200,
      Colors.green.shade200,
    ];

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < categories.length; i++) {
      paint.color = colors[i % colors.length];
      canvas.drawArc(
          Rect.fromLTWH(0, 0, size.width, size.height),
          i * sweepAngle,
          sweepAngle,
          true,
          paint);

      final angle = (i * sweepAngle) + (sweepAngle / 2);
      final textSpan = TextSpan(
        text: categories[i],
        style: TextStyle(
          fontSize: size.width * 0.07,
          fontFamily: 'ComicSans',
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );
      textPainter.text = textSpan;
      textPainter.layout();

      final radius = size.width / 3.2;
      final dx = size.width / 2 + radius * cos(angle);
      final dy = size.height / 2 + radius * sin(angle);
      final offset = Offset(dx - textPainter.width / 2, dy - textPainter.height / 2);
      textPainter.paint(canvas, offset);
    }

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 3;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}