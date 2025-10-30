import 'package:flutter/material.dart';
import 'actividadesfactor1.dart';
import 'actividadmes1sem1.dart';
import 'actividadesnoche1.dart';
import 'verdeevaluacion4.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mes4VerdePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.0),
        child: Stack(
          children: [
            AppBar(
              title: Text(
                '🎭 Escenario del Aprendizaje 🎭',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 3)],
                ),
              ),
              backgroundColor: Colors.black,
              elevation: 10,
              centerTitle: true,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/escenario.jpg',
                fit: BoxFit.cover,
                height: 130,
                opacity: AlwaysStoppedAnimation(0.9),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.deepPurple.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTheaterModule(context, '🎬 Acto 1: Introducción', [
                  _buildActivityButton(context, 'Actividad 1', FontAwesomeIcons.ticket, ActividadesFactor1(), Colors.deepPurple),
                  _buildActivityButton(context, 'Actividad 2', FontAwesomeIcons.ticket, ActividadesNoche1(), Colors.blueAccent),
                  _buildActivityButton(context, 'Actividad 3', FontAwesomeIcons.theaterMasks, ActividadMes1Sem1(), Colors.pinkAccent),
                ]),
                _buildTheaterModule(context, '🎼 Acto 2: Exploración', [
                  _buildActivityButton(context, 'Actividad 1', FontAwesomeIcons.ticket, ActividadesFactor1(), Colors.purpleAccent),
                  _buildActivityButton(context, 'Actividad 2', FontAwesomeIcons.ticket, ActividadesNoche1(), Colors.teal),
                  _buildActivityButton(context, 'Actividad 3', FontAwesomeIcons.theaterMasks, ActividadMes1Sem1(), Colors.greenAccent),
                ]),
                _buildTheaterModule(context, '🎤 Acto 3: Expresión', [
                  _buildActivityButton(context, 'Actividad 1', FontAwesomeIcons.ticket, ActividadesFactor1(), Colors.pink),
                  _buildActivityButton(context, 'Actividad 2', FontAwesomeIcons.ticket, ActividadesNoche1(), Colors.lightBlue),
                  _buildActivityButton(context, 'Actividad 3', FontAwesomeIcons.theaterMasks, ActividadMes1Sem1(), Colors.purple),
                ]),
                _buildTheaterModule(context, '🌟 Acto Final: Evaluación', [
                  _buildActivityButton(context, 'Cierre del Espectáculo', FontAwesomeIcons.solidStar, Verdeevaluacion4(), Colors.redAccent),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTheaterModule(BuildContext context, String title, List<Widget> buttons) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.black87.withOpacity(0.85),
      margin: EdgeInsets.symmetric(vertical: 12),
      elevation: 12,
      child: ExpansionTile(
        leading: Icon(FontAwesomeIcons.lightbulb, color: Colors.amberAccent, size: 30),
        title: Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        children: buttons,
      ),
    );
  }

  Widget _buildActivityButton(BuildContext context, String title, IconData icon, Widget page, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
        icon: Icon(icon, color: Colors.white, size: 22),
        label: Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}










