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

class _PantallaSiguiente extends State<PantallaSiguiente> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  static Future<User?> loginUsingEmailPassword({required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found for that email");
      } else if (e.code == "wrong-password") {
        print("Incorrect password provided");
      }
    } catch (e) {
      print("Error: $e");
    }
    return user;
  }

  void ContinueDart(BuildContext context) {
    String password = _passwordController.text.trim();

    if (password.isEmpty) {
      AnimatedSnackBar.rectangle(
        'Warning',
        'Ingresa una contraseña',
        type: AnimatedSnackBarType.warning,
        brightness: Brightness.dark,
      ).show(context);
    } else if (password.length < 6) {
      AnimatedSnackBar.rectangle(
        'Warning',
        'La contraseña debe tener 6 caracteres',
        type: AnimatedSnackBarType.warning,
        brightness: Brightness.dark,
      ).show(context);
    }
  }

  void ContinueDart2(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      AnimatedSnackBar.rectangle(
        'Warning',
        'Ingresa un correo',
        type: AnimatedSnackBarType.warning,
        brightness: Brightness.dark,
      ).show(context);
    } else if (!email.contains("@") || !email.contains(".com")) {
      AnimatedSnackBar.rectangle(
        'Warning',
        'Correo invalido, falta @ o .com',
        type: AnimatedSnackBarType.warning,
        brightness: Brightness.dark,
      ).show(context);
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } catch (e) {
        AnimatedSnackBar.rectangle(
          'Error',
          'Correo o contraseña invalidos verifica los campos',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.dark,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: 400,
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
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
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: !_passwordVisible,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock, color: Color(0xFF333333)),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(scale: animation, child: child);
                        },
                        child: _passwordVisible
                            ? const Icon(Icons.visibility, key: Key('visible'))
                            : const Icon(Icons.visibility_off, key: Key('invisible')),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const CreateAccn()),
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
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              RawMaterialButton(
                fillColor: Color.fromARGB(255, 0, 0, 0),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 100.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0),
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
