import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'actividadesfactor1.dart';
import 'actividadmes1sem1.dart';
import 'actividadesnoche1.dart';
import 'verdeevaluacion5.dart';

class Mes5VerdePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes 5', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown.shade800)),
        backgroundColor: Colors.amber.shade200,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.brown.shade800),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade100, Colors.cyan.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/banner.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 6, offset: Offset(0, 4)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildExpansionTile(context, 'Semana 1', FontAwesomeIcons.baby, [
                      _buildNavButton(context, 'Actividad 1', ActividadMes1Sem1()),
                      _buildNavButton(context, 'Actividad 2', ActividadesFactor1()),
                      _buildNavButton(context, 'Actividad 3', ActividadesNoche1()),
                    ]),
                    _buildExpansionTile(context, 'Semana 2', FontAwesomeIcons.babyCarriage, [
                      _buildNavButton(context, 'Actividad 1', ActividadMes1Sem1()),
                      _buildNavButton(context, 'Actividad 2', ActividadesFactor1()),
                      _buildNavButton(context, 'Actividad 3', ActividadesNoche1()),
                    ]),
                    _buildExpansionTile(context, 'Semana 3', FontAwesomeIcons.handHoldingHeart, [
                      _buildNavButton(context, 'Actividad 1', ActividadMes1Sem1()),
                      _buildNavButton(context, 'Actividad 2', ActividadesFactor1()),
                      _buildNavButton(context, 'Actividad 3', ActividadesNoche1()),
                    ]),
                    _buildExpansionTile(context, 'Semana 4', FontAwesomeIcons.star, [
                      _buildNavButton(context, 'Actividad 1', ActividadMes1Sem1()),
                      _buildNavButton(context, 'Actividad 2', ActividadesFactor1()),
                      _buildNavButton(context, 'Actividad 3', ActividadesNoche1()),
                      _buildNavButton(context, 'EVALUACIÓN MENSUAL', VerdeEvaluacion5Page(), isImportant: true),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context, String title, IconData icon, List<Widget> buttons) {
    return Card(
      color: Colors.amber.shade50,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.brown.shade800, size: 28),
        iconColor: Colors.brown.shade800,
        title: Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown.shade800),
        ),
        children: buttons,
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String text, Widget page, {bool isImportant = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isImportant ? Colors.red.shade600 : Colors.amber.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 5,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shadowColor: Colors.grey.shade400,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_arrow, color: Colors.white),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}



