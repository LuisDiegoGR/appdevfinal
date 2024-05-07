import 'package:appdevfinal/CreateAcc.dart';
import 'package:appdevfinal/InicioApp.dart';
import 'package:appdevfinal/forgot_password_screen.dart'; // Importa la nueva pantalla
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PantallaSiguiente extends StatefulWidget {
  const PantallaSiguiente({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PantallaSiguiente createState() => _PantallaSiguiente();
}

class _PantallaSiguiente extends State<PantallaSiguiente> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static Future<User?> loginUsingEmailPassword({required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found"){
        print("No user found for that email");
      }
    } catch (e) {
      print("Error: $e");
    }
    return user;
  }

  void ContinueDart(BuildContext context) {
    String password = _passwordController.text.trim();

    if(password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Porfavor, ingresa una contraseña',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0
          ),
          ),
          backgroundColor: Color(0xFF145647),
        ),
      );
    } else if (password.length <6){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La contraseña debe contener 6 caracteres',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0
          ),
          ),
          backgroundColor: Color(0xFF145647),
        )
      );
    }
  }

  void ContinueDart2(BuildContext context){
    String email = _emailController.text.trim();

    if(email.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Porfavor, ingrese un correo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0
            ),
          ),
          backgroundColor: Color(0xFF145647),
        ),
      );
    } else if (!email.contains("@") || !email.contains(".com")){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Correo invalido falta @ o .com',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0
        ),
        ),
        backgroundColor: Color(0xFF145647),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 203, 203, 203),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'name@example.com',
                    prefixIcon: Icon(Icons.mail, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 203, 203, 203),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => CreateAccn())
                      );
                    },
                    child: Text(
                      'Create account',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      // Aquí irá la lógica para la pantalla de recuperar contraseña
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              RawMaterialButton(
                fillColor: const Color(0xFF145647),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 100.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () async {
                  User? user = await loginUsingEmailPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  print(user);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const InicioApp()),
                  );
                  }
                  ContinueDart2(context);
                  ContinueDart(context);
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
      ),
    );
  }
}