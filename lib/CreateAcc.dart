import 'package:appdevfinal/pantalla_siguiente.dart';
import 'package:flutter/material.dart';

class CreateAccn extends StatefulWidget {
  const CreateAccn({super.key});

  @override
  State<CreateAccn> createState() => _CreateAccnState();
}

class _CreateAccnState extends State<CreateAccn> {
  String _selectedItem = 'Admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PantallaSiguiente())
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20),
              DropdownButton(
                value: _selectedItem,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue!;
                  });
                },
                items: <String>['Admin','Paciente'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      ),
                  );
                }).toList(),
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                iconSize: 30,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                isExpanded: true,
              ),
              const SizedBox(height: 20),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 203, 203, 203),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'name@example.com',
                    prefixIcon: Icon(Icons.mail, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 203, 203, 203),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const TextField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.password, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 203, 203, 203),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400, // Ancho deseado del TextField
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 203, 203, 203),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              RawMaterialButton(
                fillColor: const Color(0xFF145647),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 100.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () {
                  //Pacer
                },
                child: const Text(
                  'Create',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}