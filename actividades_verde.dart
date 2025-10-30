import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Importa google_fonts
import 'actividadesmesverde4.dart';
import 'actividadesmesverde5.dart';
import 'actividadesmesverde6.dart';

class ActividadesVerdePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ACTIVIDADES MES VERDE',
          style: GoogleFonts.dancingScript( // Usar Dancing Script desde google_fonts
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple[600],
        elevation: 8,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[200]!, Colors.purple[100]!, Colors.pink[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildModuleButton(context, 'MES 4', Icons.calendar_today, ActividadesMesVerde4(), screenWidth),
              SizedBox(height: screenHeight * 0.05),
              _buildModuleButton(context, 'MES 5', Icons.child_care, ActividadesMesVerde5(), screenWidth),
              SizedBox(height: screenHeight * 0.05),
              _buildModuleButton(context, 'MES 6', Icons.accessibility_new, ActividadesMesVerde6(), screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModuleButton(BuildContext context, String title, IconData icon, Widget page, double screenWidth) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple[700], // Color de fondo del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: screenWidth * 0.2),
        elevation: 12,
        shadowColor: Colors.pinkAccent, // Sombra suave en los botones
      ),
      icon: Icon(icon, color: Colors.white, size: 28),
      label: Text(
        title,
        style: GoogleFonts.roboto( // Usar Roboto desde google_fonts
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}











