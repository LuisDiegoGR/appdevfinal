import 'package:appdevfinal/TerceraPage.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/Perfil.jpg'),
            )
          ],
        ),
      ),
    );
  }
}