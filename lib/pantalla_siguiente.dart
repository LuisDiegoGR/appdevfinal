import 'package:appdevfinal/CreateAcc.dart';
import 'package:appdevfinal/InicioApp.dart';
import 'package:appdevfinal/InicioAppAdmin.dart';
import 'package:appdevfinal/forgot_password_screen.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PantallaSiguiente extends StatefulWidget {
  const PantallaSiguiente({super.key});

  @override
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
        const SnackBar(
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
        const SnackBar(
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
        const SnackBar(
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
        const SnackBar(content: Text('Correo invalido falta @ o .com',
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
                width: 400, 
                padding:
                    const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'name@example.com',
                    prefixIcon: Icon(Icons.mail, color: Color(0xFF333333)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 400, 
                padding:
                    const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF333333)),
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
                        MaterialPageRoute(builder: (context) => const CreateAccn())
                      );
                    },
                    child: const Text(
                      'Create account',
                      style: TextStyle(
                        color: Color(0xFF333333), 
                        fontSize: 16, 
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF333333),
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
                  borderRadius: BorderRadius.circular(30.0),
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
        String? role = (documentSnapshot.data() as Map<String, dynamic>)['role'];

        if (role == 'admin') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AdminPage()),
          );
        } else if (role == 'patient') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const InicioApp()),
          );
        }
      } else {
        print('El documento del usuario no existe');
      }
    }).catchError((error) {
      print('Error al obtener el rol del usuario: $error');
    });
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