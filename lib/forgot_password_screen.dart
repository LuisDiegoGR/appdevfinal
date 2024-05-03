import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Forgot Your Password?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 203, 203, 203),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.mail, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Aquí irá la lógica para enviar el correo de recuperación de contraseña
                  // Puedes implementar la lógica aquí para enviar un correo al usuario
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF145647)), // Color de fondo del botón
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0),
                  ),
                ),
                child: Text(
                  'Send Reset Email',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
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
