import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pantalla_siguiente.dart';
import 'privacy_notice.dart';

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
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _weeksController = TextEditingController();
  final TextEditingController _babyWeightController = TextEditingController();
  final TextEditingController _deliveryTypeController = TextEditingController();
  final TextEditingController _motherAgeController = TextEditingController();
  final TextEditingController _folioController = TextEditingController();


  UserRole _selectedRole = UserRole.patient;
  bool _showCodeField = false;
  bool _codeIsValid = true;
  bool _privacyNoticeRead = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _register() async {
  if (_selectedRole == UserRole.admin && _codeController.text != '123librefuego') {
    setState(() {
      _codeIsValid = false;
    });
    return;
  }

  if (_formKey.currentState!.validate()) {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Datos básicos de todos los usuarios
      final userData = {
        'name': _nameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'address': _addressController.text.trim(),
        'phone': _phoneController.text.trim(),
        'role': _selectedRole == UserRole.admin ? 'admin' : 'patient',
        'email': _emailController.text.trim(),
      };

      // Datos solo para pacientes
      if (_selectedRole == UserRole.patient) {
        userData.addAll({
          'fecha_registro': _dateController.text.trim(),
          'Edad_bebe': _weeksController.text.trim(),
          'Edad_madre': _motherAgeController.text.trim(),
          'Producto': _deliveryTypeController.text.trim(),
          'Peso_bebe': _babyWeightController.text.trim(),
          'folio': _folioController.text.trim(),
        });
      }

      await _firestore.collection('users').doc(userCredential.user!.uid).set(userData);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PantallaSiguiente()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar usuario: $e')),
      );
    }
  }
}


  InputDecoration _inputDecoration(String label, IconData icon, Color color) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: color),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: color.withOpacity(0.7), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: color, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {bool obscure = false, TextInputType keyboardType = TextInputType.text, required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black87, fontSize: 16),
        decoration: _inputDecoration(label, icon, color),
        validator: (value) => (value == null || value.isEmpty) ? 'Campo requerido' : null,
      ),
    );
  }

  Widget _buildRoleDropdown(Color color) {
    return DropdownButtonFormField<UserRole>(
      value: _selectedRole,
      decoration: _inputDecoration('Seleccione un Rol', Icons.person_outline, color),
      onChanged: (value) {
        setState(() {
          _selectedRole = value!;
          _showCodeField = value == UserRole.admin;
          _codeIsValid = true;
          _privacyNoticeRead = false; // Reset privacidad al cambiar rol
        });
      },
      items: UserRole.values
          .map((role) => DropdownMenuItem(
                value: role,
                child: Text(role == UserRole.admin ? 'Personal de la salud' : 'Paciente'),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Definimos los estilos según rol seleccionado
    final bool isAdmin = _selectedRole == UserRole.admin;

    final Color primaryColor = isAdmin ? Colors.grey.shade800 : Colors.deepPurple;
    final Color backgroundColor = isAdmin ? Colors.grey.shade100 : const Color(0xFFD1C4E9);
    final Color buttonColor = isAdmin ? Colors.blueGrey.shade700 : Colors.deepPurple;
    final String titleText = isAdmin ? 'Registro Personal de Salud' : 'Crear Cuenta Paciente';
    final TextStyle titleStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: primaryColor,
      letterSpacing: 1.2,
      fontFamily: isAdmin ? 'RobotoSlab' : 'Montserrat',
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
            child: Container(
              padding: const EdgeInsets.all(28),
              constraints: const BoxConstraints(maxWidth: 480),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: isAdmin ? Colors.grey.shade400 : Colors.deepPurple.shade100,
                    blurRadius: 22,
                    offset: const Offset(0, 12),
                  )
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isAdmin)
                      Icon(Icons.medical_services, size: 100, color: primaryColor)
                    else
                      Image.asset('assets/images/create.png', height: 120),
                    const SizedBox(height: 24),
                    Text(titleText, style: titleStyle, textAlign: TextAlign.center),
                    const SizedBox(height: 32),

                    _buildRoleDropdown(primaryColor),

                    if (_showCodeField)
                      Column(
                        children: [
                          _buildTextField(_codeController, 'Código de acceso', Icons.lock,
                              color: primaryColor),
                          if (!_codeIsValid)
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                'Código incorrecto',
                                style: TextStyle(color: Colors.redAccent.shade700, fontWeight: FontWeight.w700),
                              ),
                            ),
                        ],
                      ),

                    _buildTextField(_emailController, 'Correo Electrónico', Icons.email,
                        keyboardType: TextInputType.emailAddress, color: primaryColor),
                    _buildTextField(_passwordController, 'Contraseña', Icons.lock,
                        obscure: true, color: primaryColor),
                    _buildTextField(_confirmPasswordController, 'Confirmar Contraseña', Icons.lock_outline,
                        obscure: true, color: primaryColor),
                    _buildTextField(_nameController, 'Nombre', Icons.person, color: primaryColor),
                    _buildTextField(_lastNameController, 'Apellido', Icons.person_outline, color: primaryColor),
                    _buildTextField(_addressController, 'Dirección', Icons.home, color: primaryColor),
                    _buildTextField(_phoneController, 'Teléfono', Icons.phone,
                        keyboardType: TextInputType.phone, color: primaryColor),

                    if (!isAdmin) ...[
                      _buildTextField(_dateController, 'Fecha de Registro', Icons.calendar_today,
                          keyboardType: TextInputType.datetime, color: primaryColor),
                      _buildTextField(_weeksController, 'Edad del Bebé (semanas)', Icons.cake,
                          keyboardType: TextInputType.number, color: primaryColor),
                      _buildTextField(_babyWeightController, 'Peso del Bebé (g)', Icons.monitor_weight,
                          keyboardType: TextInputType.number, color: primaryColor),
                      _buildTextField(_deliveryTypeController, 'Tipo de Parto', Icons.local_hospital, color: primaryColor),
                      _buildTextField(_motherAgeController, 'Edad de la Madre', Icons.pregnant_woman,
                          keyboardType: TextInputType.number, color: primaryColor),
                      _buildTextField(_folioController, 'Folio del Paciente', Icons.confirmation_num, color: primaryColor),

                    ],

                    const SizedBox(height: 28),

                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor.withOpacity(0.1),
                        foregroundColor: buttonColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        side: BorderSide(color: buttonColor.withOpacity(0.4)),
                      ),
                      icon: Icon(Icons.privacy_tip, color: buttonColor),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrivacyNoticePage()),
                        );
                        if (result == true) {
                          setState(() {
                            _privacyNoticeRead = true;
                          });
                        }
                      },
                      label: Text(
                        'Aviso de privacidad',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: buttonColor,
                            fontSize: 16),
                      ),
                    ),

                    const SizedBox(height: 18),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _privacyNoticeRead && (_codeIsValid) ? buttonColor : buttonColor.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28)),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                      ),
                      onPressed: _privacyNoticeRead && (_codeIsValid) ? _register : null,
                      child: Text(
                        'Registrar',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}





