import 'package:flutter/material.dart';

class BalbuceosPage extends StatefulWidget {
  const BalbuceosPage({Key? key}) : super(key: key);

  @override
  State<BalbuceosPage> createState() => _BalbuceosPageState();
}

class _BalbuceosPageState extends State<BalbuceosPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<String> tips = [
    "👶 Háblale frecuentemente al bebé usando palabras sencillas.",
    "🎶 Repite los sonidos que él haga para motivarlo.",
    "🎵 Juega con el bebé usando canciones y rimas.",
    "👀 Haz contacto visual mientras hablas con él.",
    "📖 Lee cuentos en voz alta y cambia el tono de voz.",
    "😊 Anímalo a responder con sonidos mientras hablas.",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F6), // rosa pastel claro
      appBar: AppBar(
        title: const Text("Balbuceos 👶"),
        backgroundColor: const Color(0xFFD1C4E9), // morado pastel
        elevation: 2,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                "🗣️ Desarrollo de los Balbuceos",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A), // morado oscuro pastel
                ),
              ),
              const SizedBox(height: 16),
              _buildCard(
                icon: Icons.record_voice_over,
                title: "Primeros sonidos",
                description: "El bebé empieza con sonidos como 'ah' y 'oh'.",
              ),
              _buildCard(
                icon: Icons.replay_circle_filled,
                title: "Repetición de sílabas",
                description: "Empieza a repetir sílabas como 'ba-ba' o 'da-da'.",
              ),
              _buildCard(
                icon: Icons.hearing,
                title: "Imitación",
                description: "Alrededor de los 6 meses, intenta imitar sonidos.",
              ),
              const SizedBox(height: 24),
              const Text(
                "💡 Cómo Estimular los Balbuceos",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              const SizedBox(height: 16),
              ...tips.map((tip) => _buildTipCard(tip)).toList(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9FB), // crema pastel claro
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, size: 36, color: Colors.purple[300]),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildTipCard(String tip) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F5FE), // azul pastel claro
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade100, width: 1),
      ),
      child: ListTile(
        leading: const Icon(Icons.lightbulb_outline, color: Colors.deepPurple),
        title: Text(
          tip,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
