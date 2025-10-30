import 'package:appdevfinal/pantalla_siguiente.dart';
import 'package:appdevfinal/src/providers/push_notifications_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
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
  } catch (e) {
    // Si ya está inicializado, simplemente ignoramos el error
    debugPrint("⚠ Firebase ya estaba inicializado: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HRAEI',
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 55,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 3, 3, 3),
          ),
          headlineMedium: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 34,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: Colors.black87,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        primaryColor: const Color(0xFF145647),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 3));
    _initNotifications();
    await _controller.reverse();
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void _initNotifications() {
    final pushProvider = PushNotificationProvider();
    pushProvider.initNotifications();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFC1E3), Color(0xFFE0FFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7986CB).withOpacity(0.4),
                    spreadRadius: 8,
                    blurRadius: 16,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: const CircularProgressIndicator(
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🔹 Botón adaptativo según el dispositivo
  Widget _buildResponsiveButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double horizontalPadding;
    double verticalPadding;
    double fontSize;

    if (screenWidth >= 1000) {
      // 💻 PC
      horizontalPadding = screenWidth * 0.2;
      verticalPadding = 25;
      fontSize = 28;
    } else if (screenWidth >= 600) {
      // 📱 Tablet
      horizontalPadding = screenWidth * 0.15;
      verticalPadding = 22;
      fontSize = 26;
    } else {
      // 📱 Teléfono
      horizontalPadding = screenWidth * 0.1;
      verticalPadding = 18;
      fontSize = 22;
    }

    return RawMaterialButton(
      fillColor: Colors.pinkAccent.shade100,
      elevation: 5.0,
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PantallaSiguiente()),
        );
      },
      child: Text(
        'COMENZAR',
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE4E1), Color(0xFFBFEFFF), Color(0xFFFFFACD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: Text(
                    'HRAEI',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const SizedBox(height: 30),
                FadeTransition(
                  opacity: _animation,
                  child: Text(
                    'Rehabilitación Pediátrica',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 40),
                FadeTransition(
                  opacity: _animation,
                  child: Image.asset(
                    'assets/gifs/bebe_gateando.gif',
                    width: 320,
                  ),
                ),
                const SizedBox(height: 60),
                // ✅ Aquí se aplica el botón adaptativo
                FadeTransition(
                  opacity: _animation,
                  child: _buildResponsiveButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}