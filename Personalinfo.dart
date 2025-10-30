import 'package:appdevfinal/TerceraPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late String _userId;

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => PersonalInfo()),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => PersonalInfo()),
              );
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE8EAF6), Color.fromARGB(255, 244, 143, 253)],
            ),
          ),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(_userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('No se encontraron datos'));
              }

              var userData = snapshot.data!.data() as Map<String, dynamic>;

              // Valores usando ambos formatos
              final nombre = userData['nombre'] ?? userData['name'] ?? '';
              final apellido = userData['apellido'] ?? userData['lastName'] ?? '';
              final direccion = userData['direccion'] ?? userData['address'] ?? '';
              final telefono = userData['telefono'] ?? userData['phone'] ?? '';
              final edadBebe = userData['Edad_bebe'] ?? '';
              final edadMadre = userData['Edad_madre'] ?? '';
              final pesoBebe = userData['Peso_bebe'] ?? '';
              final producto = userData['Producto'] ?? '';
              final folio = userData['folio'] ?? '';
              final fechaRegistro = userData['fecha_registro'] ?? '';
              final email = userData['email'] ?? '';

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/info.png',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 30),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation: 8,
                        shadowColor: Colors.black45,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow(Icons.person, 'Nombre', '$nombre $apellido'),
                              const Divider(),
                              _buildInfoRow(Icons.home, 'Dirección', direccion),
                              const Divider(),
                              _buildInfoRow(Icons.phone, 'Teléfono', telefono),
                              const Divider(),
                              _buildInfoRow(Icons.child_care, 'Edad del bebé (semanas)', edadBebe),
                              if (edadMadre.isNotEmpty) ...[
                                const Divider(),
                                _buildInfoRow(Icons.pregnant_woman, 'Edad de la madre', edadMadre),
                              ],
                              if (pesoBebe.isNotEmpty) ...[
                                const Divider(),
                                _buildInfoRow(Icons.monitor_weight, 'Peso del bebé', pesoBebe),
                              ],
                              if (producto.isNotEmpty) ...[
                                const Divider(),
                                _buildInfoRow(Icons.local_hospital, 'Tipo de parto', producto),
                              ],
                              if (folio.isNotEmpty) ...[
                                const Divider(),
                                _buildInfoRow(Icons.confirmation_num, 'Folio', folio),
                              ],
                              if (fechaRegistro.isNotEmpty) ...[
                                const Divider(),
                                _buildInfoRow(Icons.calendar_today, 'Fecha de registro', fechaRegistro),
                              ],
                              if (email.isNotEmpty) ...[
                                const Divider(),
                                _buildInfoRow(Icons.email, 'Correo', email),
                              ],
                              const SizedBox(height: 20),
                              Center(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.edit, color: Colors.white),
                                  onPressed: () => _showEditDialog(userData),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  label: const Text(
                                    'Editar Información',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '$label: $value',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _showEditDialog(Map<String, dynamic> userData) {
    _nameController.text = userData['nombre'] ?? userData['name'] ?? '';
    _lastNameController.text = userData['apellido'] ?? userData['lastName'] ?? '';
    _addressController.text = userData['direccion'] ?? userData['address'] ?? '';
    _phoneController.text = userData['telefono'] ?? userData['phone'] ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Información Personal'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Nombre', _nameController),
                const SizedBox(height: 10),
                _buildTextField('Apellido', _lastNameController),
                const SizedBox(height: 10),
                _buildTextField('Dirección', _addressController),
                const SizedBox(height: 10),
                _buildTextField('Teléfono', _phoneController),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection('users').doc(_userId).update({
                  'nombre': _nameController.text,
                  'apellido': _lastNameController.text,
                  'direccion': _addressController.text,
                  'telefono': _phoneController.text,
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text('Guardar Cambios'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}



