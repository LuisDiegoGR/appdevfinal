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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const TerceraPag()),
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
            colors: [Color(0xFFE8EAF6), Color(0xFF7986CB)],
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

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/info.png',
                      width: 250,
                      height: 250,
                    ),
                    const SizedBox(height: 20),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person, color: Colors.black, size: 30),
                                const SizedBox(width: 10),
                                Text(
                                  '${userData['name']} ${userData['lastName']}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.home, color: Colors.black54, size: 20),
                                const SizedBox(width: 10),
                                Text(
                                  'Dirección: ${userData['address']}',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.phone, color: Colors.black54, size: 20),
                                const SizedBox(width: 10),
                                Text(
                                  'Teléfono: ${userData['phone']}',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.edit, color: Colors.white),
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
                                                  cursorColor: Colors.black,
                                                  style: const TextStyle(color: Colors.black),
                                                  decoration: const InputDecoration(
                                                    labelText: 'Nombre',
                                                    labelStyle: TextStyle(color: Colors.black),
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
                                                  cursorColor: Colors.black,
                                                  style: const TextStyle(color: Colors.black),
                                                  decoration: const InputDecoration(
                                                    labelText: 'Apellido',
                                                    labelStyle: TextStyle(color: Colors.black),
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
                                                  cursorColor: Colors.black,
                                                  style: const TextStyle(color: Colors.black),
                                                  decoration: const InputDecoration(
                                                    labelText: 'Dirección',
                                                    labelStyle: TextStyle(color: Colors.black),
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
                                                  cursorColor: Colors.black,
                                                  style: const TextStyle(color: Colors.black),
                                                  decoration: const InputDecoration(
                                                    labelText: 'Teléfono',
                                                    labelStyle: TextStyle(color: Colors.black),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              ElevatedButton.icon(
                                                icon: const Icon(Icons.save, color: Colors.white),
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
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors.black,
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 12, horizontal: 50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                  ),
                                                ),
                                                label: const Text(
                                                  'Guardar Cambios',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
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
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                label: const Text(
                                  'Editar',
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
    );
  }
}
