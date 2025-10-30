import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class GestosPage extends StatelessWidget {
  const GestosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3FD), // fondo lila claro
      appBar: AppBar(
        title: const Text("Crianza con Amor"),
        backgroundColor: const Color(0xFFD1C4E9),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection(
            title: "🤱 Vínculo Temprano",
            items: [
              _buildCard(
                context,
                "Apego Seguro",
                "El contacto físico brinda confianza, seguridad y autoestima al bebé.",
                Icons.favorite,
                "El apego fortalece la relación emocional y permite que el bebé explore su entorno con seguridad.",
              ),
              _buildCard(
                context,
                "Estimulación desde el nacimiento",
                "Hablarle y acariciarlo estimula sentidos y emociones.",
                Icons.spa,
                "Desde el nacimiento, hablar y acariciar al bebé estimula su sistema nervioso y fomenta el aprendizaje.",
              ),
            ],
          ),
          _buildSection(
            title: "🗣️ Comunicación Temprana",
            items: [
              _buildCard(
                context,
                "Gestos importantes",
                "Saludar, señalar o levantar brazos son formas clave de comunicación temprana.",
                Icons.waving_hand,
                "Saludar, señalar y levantar los brazos son gestos que expresan necesidades antes del habla.",
              ),
              _buildCard(
                context,
                "Mirada y sonidos",
                "Observar expresiones y repetir sonidos enriquece su lenguaje.",
                Icons.visibility,
                "Hablarle en actividades cotidianas enriquece su vocabulario y conexión emocional.",
              ),
            ],
          ),
          _buildSection(
            title: "🧠 Hábitos y Autonomía",
            items: [
              _buildTip(context, "Deja que explore texturas y sonidos.", "Esto estimula sus sentidos y su curiosidad."),
              _buildTip(context, "Juega a aplaudir, saludar o esconder objetos.", "La imitación refuerza memoria y comunicación."),
              _buildTip(context, "Inclúyelo en actividades como vestirse o comer.", "Promueve su autonomía desde temprano."),
              _buildTip(context, "Arrúllalo con música y caricias.", "Tranquiliza al bebé y fortalece el vínculo emocional."),
            ],
          ),
          _buildSection(
            title: "📌 Recomendaciones",
            items: [
              _buildTip(context, "Evita el uso de andaderas.", "No ayudan al desarrollo del equilibrio ni percepción espacial."),
              _buildTip(context, "No lo despiertes para comer.", "Respeta su ritmo de sueño y alimentación."),
              _buildTip(context, "Usa lenguaje claro, no infantilizado.", "Nombrar bien los objetos mejora su vocabulario real."),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeIn(
          duration: const Duration(milliseconds: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ),
        ),
        ...items.map((w) => FadeInUp(duration: const Duration(milliseconds: 400), child: w)),
      ],
    );
  }

  Widget _buildCard(BuildContext context, String title, String desc, IconData icon, String message) {
    return GestureDetector(
      onTap: () => _showMessage(context, message),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade100,
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple.shade100,
            child: Icon(icon, color: Colors.purple.shade700),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(desc),
          trailing: const Icon(Icons.info_outline),
        ),
      ),
    );
  }

  Widget _buildTip(BuildContext context, String tip, String message) {
    return GestureDetector(
      onTap: () => _showMessage(context, message),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEDE7F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.deepPurple.shade300),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                tip,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }
}



