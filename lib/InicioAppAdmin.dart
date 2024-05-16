import 'dart:io';
import 'package:appdevfinal/CitasReb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  File? _image;
  late String _userId;

  @override
  void initState(){
    super.initState();
    _userId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
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
            SizedBox(height: 20), // Espacio entre el avatar y el StreamBuilder
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(_userId)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } 
                if (!snapshot.hasData || !snapshot.data!.exists){
                  return Text('No data found');
                }

                var userData = snapshot.data!.data() as Map<String, dynamic>;

                return Padding(
                padding: const EdgeInsets.only(left: 65),
                child: ListTile(
                  title: Text(
                    '${userData['name']} ${userData['lastName']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 85),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Role ${userData['role']}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                      )
                      ),
                    ],
                  ),
                  ),
                ),
                );
              },
            ),
            SizedBox(height: 30),
            RawMaterialButton(
              fillColor: Color(0xFF145647),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 130),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CitasReb()),
                );
              },
              child: Text(
                'Citas',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 15
                ),
                ),
            ),
            SizedBox(height: 25),
            RawMaterialButton(
              fillColor: Color(0xFF145647),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 107),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () {
             //Mode unmosd
              },
              child: Text(
                'Otra opcion',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 15
                ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}