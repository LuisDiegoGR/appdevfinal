import 'package:appdevfinal/TerceraPage.dart';
import 'package:flutter/material.dart';

class Personalinfo extends StatefulWidget {
  const Personalinfo({super.key});

  @override
  State<Personalinfo> createState() => _PersonalinfoState();
}

class _PersonalinfoState extends State<Personalinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TerceraPag())
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/Perfil.jpg'),
            ),
            SizedBox(height: 20),
            Container(
              width: 400,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Color(0xFFE6E6E6),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Edit your name',
                  prefixIcon: Icon(Icons.person_2, color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}