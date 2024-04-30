import 'package:appdevfinal/main.dart';
import 'package:flutter/material.dart';
import 'package:appdevfinal/TerceraPage.dart';

class InicioApp extends StatefulWidget {
  const InicioApp({super.key});

  @override
  State<InicioApp> createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp> {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
appBar: AppBar(
  leading: IconButton(
    icon: Icon(Icons.account_circle),
    iconSize: 40.0,
    onPressed: () {
      //Accion a realizar
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()),
          );
    },
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.settings),
      iconSize: 40.0,
      onPressed: () {
        //paso a seguir
          Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const TerceraPag()),
          );
      },
    )
  ],
),




        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Primer contenedor con imagen delante
              Stack(
                children: [
                  Container(
                    width: 350,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Agendar cita',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 40),
                  ),
                  Positioned(
                    top: 120, // Ajusta la posición vertical del botón
                    left: 128, // Ajusta la posición horizontal del botón
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción del botón
                      },
                      child: Text(
                        'Empezar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                                        
                    'assets/images/DocGirl.png',
                    width: 130,
                    height: 290,
                    alignment: Alignment.centerRight,
                  
                    ),
                    padding: EdgeInsets.only(left: 26),
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Segundo contenedor con imagen delante
              Stack(
                children: [
                  Container(
                    width: 350,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Informacion',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120, // Ajusta la posición vertical del botón
                    left: 110, // Ajusta la posición horizontal del botón
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción del botón
                      },
                      child: Text(
                        'Empezar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                                        
                    'assets/images/DocMan.png',
                    width: 130,
                    height: 290,
                    alignment: Alignment.centerRight,
                  
                    ),
                    padding: EdgeInsets.only(left: 230),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}