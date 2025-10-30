import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:animate_do/animate_do.dart';

class AlimentacionInteractivaPage extends StatelessWidget {
  const AlimentacionInteractivaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guía Leche Materna',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        color: Colors.pink[50],
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            FadeInDown(
              child: Text(
                'Cuidados y Alimentación con Leche Materna',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800]),
              ),
            ),
            const SizedBox(height: 16),

            // Preparación
            FadeInLeft(
              child: AlimentacionItem(
                icon: LucideIcons.circle,
                title: 'Preparación',
                content: '• Lávate bien las manos con agua y jabón.\n'
                    '• Revisa que el extractor y tubos estén limpios.\n'
                    '• Cambia cualquier tubo con moho.\n'
                    '• Limpia diales y superficie de la mesa.',
              ),
            ),
            const SizedBox(height: 12),

            // Almacenamiento
            FadeInRight(
              child: AlimentacionItem(
                icon: LucideIcons.box,
                title: 'Almacenamiento',
                content: '• Usa bolsas/envases aptos con tapa hermética.\n'
                    '• Evita plásticos con bisfenol A (símbolo #7).\n'
                    '• Marca fecha de extracción y nombre del bebé si es para guardería.\n'
                    '• Guarda en el fondo del refrigerador o congelador.\n'
                    '• Congela en porciones pequeñas (2-4 oz).\n'
                    '• Deja 1 pulgada de espacio en el envase al congelar.\n'
                    '• Usa bolsa térmica con hielo máximo 24 hrs al viajar.',
              ),
            ),
            const SizedBox(height: 12),

            // Guía de almacenamiento
            FadeInLeft(
              child: AlimentacionItem(
                icon: LucideIcons.clipboardList,
                title: 'Guía de Almacenamiento',
                content: 'Recién extraída:\n'
                    '• Temp. ambiente (25°C): hasta 4 horas.\n'
                    '• Refrigerador (4°C): hasta 4 días.\n'
                    '• Congelador (-18°C): 6 meses ideal, 12 meses aceptable.\n\n'
                    'Descongelada:\n'
                    '• Temp. ambiente: 1-2 horas.\n'
                    '• Refrigerador: hasta 24 horas.\n'
                    '• No volver a congelar.\n\n'
                    'Leche sobrante (biberón): usar en máximo 2 horas.',
              ),
            ),
            const SizedBox(height: 12),

            // Descongelar
            FadeInRight(
              child: AlimentacionItem(
                icon: LucideIcons.airplay,
                title: 'Descongelar',
                content: '• Usar siempre primero la más antigua.\n'
                    '• Descongelar en refrigerador o bajo agua tibia.\n'
                    '• No usar microondas.\n'
                    '• Usar en 24 horas una vez descongelada.\n'
                    '• Una vez calentada o a temperatura ambiente: usar en 2 horas.\n'
                    '• Nunca recongelar.',
              ),
            ),
            const SizedBox(height: 12),

            // Alimentación
            FadeInLeft(
              child: AlimentacionItem(
                icon: LucideIcons.baby,
                title: 'Alimentación',
                content: '• Se puede dar fría, a temperatura ambiente o tibia.\n'
                    '• Para calentar: coloca el envase en agua tibia.\n'
                    '• No calentar en microondas o estufa.\n'
                    '• Probar temperatura en tu muñeca (tibia, no caliente).\n'
                    '• Revolver antes de dar para mezclar la grasa.\n'
                    '• Si sobra leche en el biberón, usarla en máximo 2 horas.',
              ),
            ),
            const SizedBox(height: 12),

            // Limpieza
            FadeInRight(
              child: AlimentacionItem(
                icon: LucideIcons.sprayCan,
                title: 'Limpieza',
                content: '• Lavar extractor y utensilios con agua y jabón en recipiente limpio.\n'
                    '• Enjuagar con agua corriente.\n'
                    '• Secar al aire sobre toalla limpia.\n'
                    '• Desinfectar diariamente:\n'
                    '    - En lavavajillas con ciclo caliente.\n'
                    '    - Hervir 5 minutos.\n'
                    '    - Usar esterilizador de vapor.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlimentacionItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String content;

  const AlimentacionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  State<AlimentacionItem> createState() => _AlimentacionItemState();
}

class _AlimentacionItemState extends State<AlimentacionItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Icon(widget.icon, color: Colors.pinkAccent, size: 28),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        trailing: Icon(
          isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
          color: Colors.pinkAccent,
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        children: [
          Text(
            widget.content,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}









