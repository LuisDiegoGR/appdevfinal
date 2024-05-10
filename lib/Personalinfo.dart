import 'package:appdevfinal/TerceraPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TerceraPag()),
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
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No data found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return ListTile(
            title: Text('${userData['name']} ${userData['lastName']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dirección: ${userData['address']}'),
                Text('Teléfono: ${userData['phone']}'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Editar Información Personal'),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _nameController
                                ..text = userData['name'],
                              decoration: InputDecoration(labelText: 'Nombre'),
                            ),
                            TextField(
                              controller: _lastNameController
                                ..text = userData['lastName'],
                              decoration: InputDecoration(labelText: 'Apellido'),
                            ),
                            TextField(
                              controller: _addressController
                                ..text = userData['address'],
                              decoration: InputDecoration(labelText: 'Dirección'),
                            ),
                            TextField(
                              controller: _phoneController
                                ..text = userData['phone'],
                              decoration: InputDecoration(labelText: 'Teléfono'),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                // Obtener los nuevos valores de los campos
                                String newName = _nameController.text;
                                String newLastName = _lastNameController.text;
                                String newAddress = _addressController.text;
                                String newPhone = _phoneController.text;

                                // Actualizar los campos en Firestore
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
                              child: Text('Guardar Cambios'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text('Editar',
              style: TextStyle(
                color: Colors.black,
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
