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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const TerceraPag()),
            );
          },
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
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

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userData['name']} ${userData['lastName']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Dirección: ${userData['address']}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Teléfono: ${userData['phone']}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  'Editar Información Personal',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 280,
                                        padding: const EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 231, 230, 230),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: TextField(
                                          controller: _nameController
                                            ..text = userData['name'],
                                          decoration: const InputDecoration(
                                            labelText: 'Nombre',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: 280,
                                        padding: const EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 231, 230, 230),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: TextField(
                                          controller: _lastNameController
                                            ..text = userData['lastName'],
                                          decoration: const InputDecoration(
                                            labelText: 'Apellido',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: 280,
                                        padding: const EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 231, 230, 230),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: TextField(
                                          controller: _addressController
                                            ..text = userData['address'],
                                          decoration: const InputDecoration(
                                            labelText: 'Dirección',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: 280,
                                        padding: const EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 231, 230, 230),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: TextField(
                                          controller: _phoneController
                                            ..text = userData['phone'],
                                          decoration: const InputDecoration(
                                            labelText: 'Teléfono',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      RawMaterialButton(
                                        fillColor: const Color(0xFF145647),
                                        elevation: 0.0,
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        onPressed: () async {
                                          String newName = _nameController.text;
                                          String newLastName = _lastNameController.text;
                                          String newAddress = _addressController.text;
                                          String newPhone = _phoneController.text;

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(_userId)
                                              .update({
                                            'name': newName,
                                            'lastName': newLastName,
                                            'address': newAddress,
                                            'phone': newPhone,
                                          });

                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Guardar Cambios',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF145647)),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          ),
                        ),
                        child: const Text(
                          'Editar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
