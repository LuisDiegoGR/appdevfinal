import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';
import 'page_emb_2.dart';

Widget _buildCard(String title, String description, String imagePath, double offset) {
  return AnimatedContainer(
    duration: const Duration(seconds: 2),
    curve: Curves.easeInOut,
    transform: Matrix4.translationValues(0, offset, 0),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 150),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 100, color: Colors.grey);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class PageEmbarazo extends StatefulWidget {
  @override
  State<PageEmbarazo> createState() => _PageEmbarazoState();
}

class _PageEmbarazoState extends State<PageEmbarazo> with WidgetsBindingObserver, TickerProviderStateMixin {
  late List<Map<String, String>> stages;
  late List<String> motherChangesShuffled;
  final Random _random = Random();

  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  // Más datos curiosos nuevos
  final List<Map<String, String>> allStages = [
    {
      'title': 'DATO CURIOSO',
      'image': 'assets/images/flor_etapa1.png',
      'description': 'La piel de algunas mujeres brilla debido al aumento de sangre y cambios hormonales.'
    },
    {
      'title': 'DATO CURIOSO',
      'image': 'assets/images/flor_etapa2.png',
      'description': 'El cabello tiende a volverse más grueso y brillante.'
    },
    {
      'title': 'DATO CURIOSO',
      'image': 'assets/images/Embarazo_5.png',
      'description': 'El bebé gana peso rápidamente y se prepara para el nacimiento.'
    },
    {
      'title': 'DATO CURIOSO',
      'image': 'assets/images/cambio_madre1.png',
      'description': 'Los pies pueden crecer hasta una talla debido a la relajación de los ligamentos.'
    },
    {
      'title': 'DATO CURIOSO',
      'image': 'assets/images/cambio_madre2.png',
      'description': 'Es común que el sentido del olfato se vuelva más sensible.'
    },
    {
      'title': 'DATO CURIOSO',
      'image': 'assets/images/madre.png',
      'description': 'El sentido del gusto también puede cambiar durante el embarazo.'
    },
    {
      'title': 'DATO CURIOSO',
      'image': 'assets/images/Embarazo_1.png',
      'description': 'Algunas mujeres sueñan más vívidamente debido a los cambios hormonales.'
    },
    {
      'title': 'DATO CURIOSO',
      'image': 'assets/images/Embarazo_2.png',
      'description': 'El abdomen puede cambiar de forma y tamaño constantemente durante el embarazo.'
    },
    {
      'title': 'DATO CURIOSO',
      'image': 'assets/images/Embarazo_3.png',
      'description': 'Algunas mujeres experimentan cambios en la textura del cabello y uñas.'
    },
    {
      'title': 'DATO CURIOSO',
      'image': 'assets/images/Embarazo_4.png',
      'description': 'El ritmo cardíaco de la madre puede aumentar para suministrar más oxígeno al bebé.'
    },
  ];

  final List<String> motherChanges = [
    'El útero puede aumentar hasta 500 veces su tamaño normal durante el embarazo.',
    'Las náuseas matutinas no solo ocurren por la mañana, pueden durar todo el día.',
    'Algunas madres desarrollan una línea oscura llamada línea negra en su abdomen.',
    'El corazón de una mujer embarazada trabaja hasta un 50% más para bombear sangre.',
    'Es normal que algunas mujeres tengan cambios en la pigmentación de la piel.',
    'Algunas mujeres experimentan más sensibilidad emocional durante el embarazo.',
    'Algunas madres pueden notar cambios en sus uñas y cabello.',
    'El volumen sanguíneo de una mujer aumenta significativamente durante el embarazo.',
    'Algunas mujeres sienten una mayor temperatura corporal durante el embarazo.',
    'El sistema digestivo puede volverse más lento, causando acidez y estreñimiento.',
    'La memoria puede verse afectada temporalmente debido a cambios hormonales.',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadRandomData();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _floatController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadRandomData();
    }
  }

  void _loadRandomData() {
    setState(() {
      stages = List.from(allStages)..shuffle(_random);
      stages = stages.take(5).toList(); // 5 datos aleatorios para carrusel
      motherChangesShuffled = List.from(motherChanges)..shuffle(_random);
      motherChangesShuffled = motherChangesShuffled.take(5).toList(); // 5 cambios aleatorios
    });
  }

  Widget _buildMotherChangeCard(String change, double offset) {
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(0, offset, 0),
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow.shade50, Colors.pink.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: Colors.pinkAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              change,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Línea del Tiempo del Embarazo'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Etapas del Embarazo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 280.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.75,
                  ),
                  items: stages.map((stage) {
                    return Builder(
                      builder: (BuildContext context) {
                        return _buildCard(stage['title']!, stage['description']!, stage['image']!, _floatAnimation.value);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cambios en la madre:',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...motherChangesShuffled
                          .map((change) => _buildMotherChangeCard(change, _floatAnimation.value))
                          .toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageEmb2()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('VER MÁS'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}


































