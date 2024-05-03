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
            Column(
              children: [
                TextButton.icon(
                  onPressed: () {
                    //coment
                  },
                  icon:Icon(Icons.person, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFE6E6E6),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.only(top: 17, bottom: 17, left: 120, right: 120),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  label: Text(
                    'Luis Diego',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextButton.icon(
                  onPressed: () {
                    //coment
                  },
                  icon:Icon(Icons.person, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFE6E6E6),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.only(top: 17, bottom: 17, left: 100, right: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  label: Text(
                    'Ticante Corona',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextButton.icon(
                  onPressed: () {
                    //coment
                  },
                  icon:Icon(Icons.email, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFE6E6E6),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.only(top: 17, bottom: 17, left: 35, right: 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  label: Text(
                    'Luisdiegoticante@hotmail.com',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextButton.icon(
                  onPressed: () {
                    //coment
                  },
                  icon:Icon(Icons.location_city, color: Colors.black),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFE6E6E6),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.only(top: 17, bottom: 17, left: 80, right: 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  label: Text(
                    'Blvd. Acozac num 3',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}