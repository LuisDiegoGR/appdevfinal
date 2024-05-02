import 'package:appdevfinal/InicioApp.dart';
import 'package:appdevfinal/Personalinfo.dart';
import 'package:flutter/material.dart';

class TerceraPag extends StatefulWidget {
  const TerceraPag ({super.key});

  @override
  State<TerceraPag> createState() => _TerceraPagState();
}

class _TerceraPagState extends State<TerceraPag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => InicioApp()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/Perfil.jpg'), // Cambia 'assets/user_profile_image.jpg' por la ruta de tu imagen de perfil
            ),
            SizedBox(height: 20), // Espacio en blanco
            Column(
              children: [
                TextButton.icon(
                  onPressed: () {
                    // Lógica para la pantalla de Información Personal
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Personalinfo()),
                    );
                  },
                  icon:Icon(Icons.person, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFE6E6E6),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.only(top: 17, bottom: 17, left: 90, right: 90),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  label: Text(
                    'Personal Information',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                TextButton.icon(
                  onPressed: () {
                    // Lógica para la pantalla de Notificaciones
                  },
                  icon: Icon(Icons.notifications, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFE6E6E6),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.only(top: 17, bottom: 17, left: 120, right: 120),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  label: const Text(
                    'Notifications',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ), 
                  ),
                ),
                SizedBox(height: 25),
                TextButton.icon(
                  onPressed: () {

                    // Lógica para la pantalla de Citas
                  },
                  icon: Icon(Icons.calendar_month, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFE6E6E6),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.only(top: 17, bottom: 17, left: 150, right: 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  label: Text(
                    'Citas',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                TextButton.icon(
                  onPressed: () {
                    // Lógica para la pantalla de About
                  },
                  icon: Icon(Icons.info, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFE6E6E6),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.only(top: 17, bottom: 17, left: 146, right: 146),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  label: Text(
                    'About',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}