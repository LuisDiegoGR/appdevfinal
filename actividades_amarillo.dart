import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'actividadesmesamarillo4.dart';
import 'actividadesmesamarillo5.dart';
import 'actividadesmesamarillo6.dart';

class ActividadesAmarilloPage extends StatelessWidget {
  const ActividadesAmarilloPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text(
          'Actividades Nivel Amarillo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFB74D),
        centerTitle: true,
        elevation: 3,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '👶 Elige el mes para ver actividades adorables:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              _buildCuteCardButton(
                context,
                title: 'Mes 4',
                subtitle: 'Explora actividades para el 4º mes',
                icon: LucideIcons.baby,
                color: Colors.pinkAccent.shade100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ActividadesAmarillo4 ()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildCuteCardButton(
                context,
                title: 'Mes 5',
                subtitle: 'Descubre juegos encantadores del 5º mes',
                icon: LucideIcons.rat,
                color: Colors.lightBlueAccent.shade100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Mes5Riesgo()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildCuteCardButton(
                context,
                title: 'Mes 6',
                subtitle: 'Aprende actividades divertidas del 6º mes',
                icon: LucideIcons.star,
                color: Colors.lightGreenAccent.shade100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ActividadesAmarillo6()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCuteCardButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(192, 20, 199, 239).withOpacity(0.3),
              offset: const Offset(2, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(icon, color: const Color.fromARGB(100, 158, 108, 182)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 36, 240, 255),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Color.fromARGB(255, 197, 94, 206)),
            ],
          ),
        ),
      ),
    );
  }
}




