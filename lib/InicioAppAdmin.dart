import 'dart:io';

import 'package:appdevfinal/CitasReb.dart';
import 'package:appdevfinal/acceptcita.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  File? _image;
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
        title: const Text('Admin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: _image != null
                  ? FileImage(_image!)
                  : (FirebaseAuth.instance.currentUser?.photoURL != null
                      ? NetworkImage(
                          FirebaseAuth.instance.currentUser!.photoURL!)
                      : const AssetImage('assets/images/Placeholder.jpg')
                          as ImageProvider),
            ),
            const SizedBox(height: 20), 
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(_userId)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Text('No data found');
                }

                var userData = snapshot.data!.data() as Map<String, dynamic>;

                return Column(
                  children: [
                    Text(
                      '${userData['name']} ${userData['lastName']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold, 
                      ),
                    ),
                    const SizedBox(height: 5), 
                    Text(
                      'Role ${userData['role']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold, 
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
            RawMaterialButton(
              fillColor: const Color(0xFF145647),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const CitasReb()),
                );
              },
              child: const Text(
                'Registro citas',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.bold, 
                ),
              ),
            ),
            const SizedBox(height: 25),
            RawMaterialButton(
              fillColor: const Color(0xFF145647),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 90),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const AcceptCita()));
              },
              child: const Text(
                'Citas Aceptadas',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.bold, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
