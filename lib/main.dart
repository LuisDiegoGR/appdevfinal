import 'package:appdevfinal/pantalla_siguiente.dart'; // Importa el archivo Dart al que quieres redirigir
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDFql2M0q4y_wKOXmG_ahxMaQ8mKvAABRM',
      authDomain: 'appdevfinal-ce7e0.web.app',
      projectId: 'appdevfinal-ce7e0',
      appId: '1:796355511021:android:3c7f416c9fe7375b2082e4',
      messagingSenderId: '796355511021',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Inicializa Firebase antes de ejecutar la aplicación
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            // Muestra un indicador de carga mientras Firebase se inicializa
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        } else {
          // Una vez que Firebase se ha inicializado correctamente, muestra la pantalla de inicio de sesión
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'HRAEI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Rehabilitacion Pediatrica',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/tre.png', // Ruta de la imagen en tu proyecto
              width: 200,
            ),
            //Navigator.pushNamed(context, '/siguiente');
            const SizedBox(height: 40),
            RawMaterialButton(
              fillColor: Color(0xFF145647),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 150.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => PantallaSiguiente()),
                );
              },
              child: const Text(
                'Comenzar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
