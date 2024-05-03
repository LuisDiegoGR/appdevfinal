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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Notificaciones',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Roboto'
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFE6E6E6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Title Notification',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ),
              SizedBox(height: 24),
              Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFE6E6E6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Title Notification',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ),
              SizedBox(height: 24),
              Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFE6E6E6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Title Notification',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
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
  }
}