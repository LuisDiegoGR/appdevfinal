import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:appdevfinal/CreateAcc.dart';
import 'package:appdevfinal/InicioApp.dart';
import 'package:appdevfinal/InicioAppAdmin.dart';
import 'package:appdevfinal/forgot_password_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PantallaSiguiente extends StatefulWidget {
  const PantallaSiguiente({super.key});

  @override
  _PantallaSiguiente createState() => _PantallaSiguiente();
}

class _PantallaSiguiente extends State<PantallaSiguiente>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animaciones al entrar
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  static Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } catch (e) {
      print("Error: $e");
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 🔹 Ajusta la pantalla al teclado
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFE6E6), // rosita suave
              Color(0xFFE6F7FF), // celeste bebé
              Color(0xFFFFF7D9), // amarillo pastel
              Color(0xFFE6FFE6), // verde menta
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView( // 🔹 Hace scroll si el teclado tapa contenido
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: 380,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo con animación suave
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          height: 120,
                          width: 120,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          "Bienvenido 👶",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF444444),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Email input
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Correo electrónico",
                            prefixIcon: const Icon(Icons.mail_outline,
                                color: Colors.pink),
                            filled: true,
                            fillColor: Colors.pink[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Password input
                        TextField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            labelText: "Contraseña",
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: Colors.blue),
                            filled: true,
                            fillColor: Colors.blue[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey[700],
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Botón de login animado
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[300],
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                            ),
                            onPressed: () async {
                              User? user = await loginUsingEmailPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              if (user != null) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) {
                                  if (documentSnapshot.exists) {
                                    String? role =
                                        (documentSnapshot.data()
                                            as Map<String, dynamic>)['role'];
                                    if (role == 'admin') {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminPage()),
                                      );
                                    } else if (role == 'patient') {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const InicioApp()),
                                      );
                                    }
                                  }
                                });
                              } else {
                                AnimatedSnackBar.rectangle(
                                  'Error',
                                  'Correo o contraseña inválidos',
                                  type: AnimatedSnackBarType.error,
                                  brightness: Brightness.dark,
                                ).show(context);
                              }
                            },
                            child: const Text(
                              "Iniciar sesión",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // 🔹 Botones de Crear cuenta y Olvidar contraseña (uno bajo otro)
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateAccn()),
                                );
                              },
                              child: const Text(
                                "Crear cuenta",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.pinkAccent),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordScreen()),
                                );
                              },
                              child: const Text(
                                "¿Olvidaste tu contraseña?",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blueAccent),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}