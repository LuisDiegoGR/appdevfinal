import 'package:appdevfinal/pantalla_siguiente.dart'; // Importa el archivo Dart al que quieres redirigir
import 'package:appdevfinal/src/providers/push_notifications_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAi-CYSt4nns6Ds2gdJVjR0WMeGmAqN7Po',
      authDomain: 'apphraei.web.app',
      projectId: 'apphraei',
      appId: '1:740916737730:android:89a5dde970d7091d35ad5b',
      messagingSenderId: '740916737730',
      storageBucket: 'gs://apphraei.appspot.com',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HRAEI',
      theme: ThemeData(
        primaryColor: Color(0xFF145647),
      ),
      home: SplashScreen(), // Mostrar la pantalla de carga al inicio
      debugShowCheckedModeBanner: false,
    );
  }
}

// Pantalla de carga personalizada
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(Duration(seconds: 3));
    _initNotifications(); // Inicia el proveedor de notificaciones
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()), // Ir a la pantalla principal
    );
  }

  // Inicia el proveedor de notificaciones
  void _initNotifications() {
    final pushProvider = PushNotificationProvider();
    pushProvider.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF145647).withOpacity(0.5),
                spreadRadius: 10,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF145647)),
          ),
        ),
      ),
    );
  }
}

// Pantalla principal de la aplicación
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

// Pantalla de error personalizada
class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Error al inicializar Firebase',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
