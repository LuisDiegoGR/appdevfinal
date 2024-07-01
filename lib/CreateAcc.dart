import 'package:appdevfinal/pantalla_siguiente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum UserRole { admin, patient }

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
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  UserRole _selectedRole = UserRole.patient;
  bool _showCodeField = false;
  bool _codeIsValid = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _register() async {
    if (_selectedRole == UserRole.admin && _codeController.text != '123librefuego') {
      setState(() {
        _codeIsValid = false;
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': _nameController.text,
          'lastName': _lastNameController.text,
          'address': _addressController.text,
          'phone': _phoneController.text,
          'role': _selectedRole == UserRole.admin ? 'admin' : 'patient',
        });

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PantallaSiguiente()),
        );
      } catch (e) {
        print("Error al registrar usuario: $e");
      }
    }
  }

  bool _validateEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@(gmail\.com|hotmail\.com|outlook\.com|yahoo\.com)$',
    );
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$',
    );
    return passwordRegex.hasMatch(password);
  }

  bool _validatePhone(String phone) {
    final RegExp phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PantallaSiguiente()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const PantallaSiguiente()),
              );
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFE8EAF6), Color(0xFF7986CB)],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        Image.asset('assets/images/create.png', height: 250),
                        const SizedBox(height: 20),
                        const Text(
                          'Crea tu cuenta',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Seleccione un Rol',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: DropdownButtonFormField<UserRole>(
                            value: _selectedRole,
                            onChanged: (value) {
                              setState(() {
                                _selectedRole = value!;
                                _showCodeField = value == UserRole.admin;
                                _codeIsValid = true;
                              });
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            items: UserRole.values.map((UserRole role) {
                              return DropdownMenuItem<UserRole>(
                                value: role,
                                child: Row(
                                  children: [
                                    Icon(
                                      role == UserRole.admin
                                          ? Icons.medical_services
                                          : Icons.person,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      role == UserRole.admin
                                          ? 'Profesional de la salud'
                                          : 'Paciente',
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        if (_showCodeField) ...[
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              controller: _codeController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                labelText: 'Código',
                                labelStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(Icons.security, color: Colors.black),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          if (!_codeIsValid)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Si no cuentas con el código, comunícate con los desarrolladores.',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Correo Electrónico',
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(Icons.mail, color: Colors.black),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su correo electrónico';
                              } else if (!_validateEmail(value)) {
                                return 'Ingrese un correo electrónico válido, \n (gmail, hotmail, outlook, yahoo)';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50), // Limit email length to 50
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: const TextStyle(color: Colors.black),
                              prefixIcon: const Icon(Icons.lock, color: Colors.black),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su contraseña';
                              } else if (!_validatePassword(value)) {
                                return 'La contraseña debe tener al menos una letra mayúscula, \n'
                                        'una letra minúscula, un número, un carácter especial \n'
                                        'y debe tener entre 8 y 15 caracteres.';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15), // Limit password length to 15
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Confirmar Contraseña',
                              labelStyle: const TextStyle(color: Colors.black),
                              prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword = !_obscureConfirmPassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirme su contraseña';
                              } else if (value != _passwordController.text) {
                                return 'Las contraseñas no coinciden';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextFormField(
                            controller: _nameController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Nombre',
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(Icons.person, color: Colors.black),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su nombre';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30), // Limit name length to 30
                              FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')), // Only allow letters and spaces
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextFormField(
                            controller: _lastNameController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Apellido',
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(Icons.person_outline, color: Colors.black),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su apellido';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30), // Limit last name length to 30
                              FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')), // Only allow letters and spaces
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextFormField(
                            controller: _addressController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Dirección',
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(Icons.home, color: Colors.black),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su dirección';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50), // Limit address length to 50
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextFormField(
                            controller: _phoneController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Teléfono',
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(Icons.phone, color: Colors.black),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su teléfono';
                              } else if (!_validatePhone(value)) {
                                return 'Ingrese un número de teléfono válido de 10 dígitos';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10), // Limit phone number length to 10
                              FilteringTextInputFormatter.digitsOnly, // Only allow digits
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: _register,
                          child: const Text('Registrar'),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
