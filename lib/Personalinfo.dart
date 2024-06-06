import 'package:appdevfinal/TerceraPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const TerceraPag()),
            );
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No data found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return ListTile(
            title: Text('${userData['name']} ${userData['lastName']}',
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 20,
            ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Dirección: ${userData['address']}',
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
                ),
                Text('Teléfono: ${userData['phone']}',
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Editar Información Personal'),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _nameController
                                ..text = userData['name'],
                              decoration: const InputDecoration(labelText: 'Nombre'),
                            ),
                            TextField(
                              controller: _lastNameController
                                ..text = userData['lastName'],
                              decoration: const InputDecoration(labelText: 'Apellido'),
                            ),
                            TextField(
                              controller: _addressController
                                ..text = userData['address'],
                              decoration: const InputDecoration(labelText: 'Dirección'),
                            ),
                            TextField(
                              controller: _phoneController
                                ..text = userData['phone'],
                              decoration: const InputDecoration(labelText: 'Teléfono'),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
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
                              child: const Text('Guardar Cambios'),
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
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                )
              ),
              child: const Text('Editar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          );
        },
      ),
    );
  }
}
