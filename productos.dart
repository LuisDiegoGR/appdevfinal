import 'package:flutter/material.dart';

class ProductosPage extends StatelessWidget {
  const ProductosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Productos para el cuidado",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[300],
      ),
      body: Container(
        color: Colors.purple[50],
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Productos recomendados para el cuidado del bebé",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            _buildProductCard(
              "Aceite para bebé",
              "Hidrata y protege la piel delicada del bebé.",
              Icons.spa,
            ),
            _buildProductCard(
              "Shampoo sin lágrimas",
              "Especialmente diseñado para el cuero cabelludo del bebé.",
              Icons.shower,
            ),
            _buildProductCard(
              "Toallitas húmedas",
              "Suaves y perfectas para la limpieza diaria.",
              Icons.cleaning_services,
            ),
            _buildProductCard(
              "Loción hidratante",
              "Mantiene la piel del bebé suave y tersa.",
              Icons.favorite,
            ),
            const SizedBox(height: 20),
            const Text(
              "Productos no recomendados y sus riesgos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            _buildRiskProductCard(
              "Talco para bebés",
              "El talco puede ser inhalado accidentalmente por el bebé, lo que podría causar problemas respiratorios graves.",
              Icons.warning_amber_rounded,
            ),
            _buildRiskProductCard(
              "Productos con fragancias fuertes",
              "Las fragancias fuertes pueden causar irritación en la piel delicada del bebé o reacciones alérgicas.",
              Icons.warning_amber_rounded,
            ),
            _buildRiskProductCard(
              "Jabones antibacteriales",
              "Pueden ser demasiado agresivos para la piel sensible del bebé, eliminando aceites naturales esenciales.",
              Icons.warning_amber_rounded,
            ),
            const SizedBox(height: 20),
            const Text(
              "Productos específicos para el cuidado de la piel",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            _buildProductCard(
              "Crema para pañalitis",
              "Ayuda a prevenir y tratar las rozaduras causadas por el pañal.",
              Icons.baby_changing_station,
            ),
            _buildProductCard(
              "Protector solar para bebés",
              "Esencial para proteger la piel del bebé al exponerlo al sol (uso recomendado a partir de 6 meses).",
              Icons.wb_sunny,
            ),
            _buildProductCard(
              "Jabón suave para bebé",
              "Formulado para no irritar la piel y mantener la hidratación natural.",
              Icons.soap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(String name, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple[300], size: 40.0),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }

  Widget _buildRiskProductCard(String name, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.red[50],
      child: ListTile(
        leading: Icon(icon, color: Colors.red[300], size: 40.0),
        title: Text(
          name,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.redAccent),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.warning, color: Colors.redAccent),
      ),
    );
  }
}

