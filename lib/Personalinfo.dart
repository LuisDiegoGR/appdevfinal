import 'package:appdevfinal/TerceraPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Personalinfo extends StatefulWidget {
  @override
  _PersonalinfoState createState() => _PersonalinfoState();
}

class _PersonalinfoState extends State<Personalinfo> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  String _userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //coment
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TerceraPag())
            );
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_userId) // Filtra por el ID del usuario actual
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var userData = snapshot.data!.data();

          return ListTile(
            title: Text('${userData?['name']} ${userData?['lastName']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dirección: ${userData?['address']}'),
                Text('Teléfono: ${userData?['phone']}'),
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
                              controller: _nameController,
                              decoration: InputDecoration(labelText: 'Nombre'),
                              onChanged: (value) {
                                // Aquí actualizas el nombre mientras el usuario escribe
                              },
                            ),
                            TextField(
                              controller: _lastNameController,
                              decoration: InputDecoration(labelText: 'Apellido'),
                            ),
                            TextField(
                              controller: _addressController,
                              decoration: InputDecoration(labelText: 'Dirección'),
                            ),
                            TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(labelText: 'Teléfono'),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                // Obtener los nuevos valores de los campos
                                String newName = _nameController.text;
                                String newLastName =
                                    _lastNameController.text;
                                String newAddress = _addressController.text;
                                String newPhone = _phoneController.text;

                                // Actualizar los campos en Firestore
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_userId) // Actualiza el documento del usuario actual
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
              child: Text('Editar'),
            ),
          );
        },
      ),
    );
  }
}
