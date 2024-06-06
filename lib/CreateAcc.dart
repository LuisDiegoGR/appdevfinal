import 'package:appdevfinal/pantalla_siguiente.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole {admin, patient}

class CreateAccn extends StatefulWidget {
  const CreateAccn({super.key});

  @override
  State<CreateAccn> createState() => _CreateAccnState();
}

class _CreateAccnState extends State<CreateAccn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  UserRole _selectedRole = UserRole.patient;

  Future<void> _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': _nameController.text,
        'lastName': _lastNameController.text,
        'address': _addressController.text,
        'phone': _phoneController.text,
        'role': _selectedRole == UserRole.admin ? 'admin' : 'patient'
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PantallaSiguiente()),
      );
    } catch (e) {
      print("Error al registar usuario: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PantallaSiguiente())
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                items: UserRole.values.map((UserRole role) {
                  return DropdownMenuItem<UserRole>(
                    value: role,
                    child: Text(role == UserRole.admin ? 'admin' : 'Paciente'),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400, // Ancho deseado del TextField
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 230, 2030),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'name@example.com',
                    prefixIcon: Icon(Icons.mail, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: _addressController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.maps_home_work, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RawMaterialButton(
                fillColor: const Color(0xFF145647),
                elevation: 0.0,
                padding: const EdgeInsets.all(9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () {
                  //Pacer
                  _register();
                },
                child: const Text(
                  'Create',
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
      ),
    );
  }
}