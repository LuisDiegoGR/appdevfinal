import 'package:appdevfinal/EvaluacionTemp.dart';
import 'package:appdevfinal/informacion1.dart';
import 'package:flutter/material.dart';

class PageAlteraciones extends StatefulWidget {
  const PageAlteraciones({super.key});

  @override
  State<PageAlteraciones> createState() => _PageAlteracionesState();
}

class _PageAlteracionesState extends State<PageAlteraciones>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Informacion1()));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Alteraciones de la succion deglucion',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  color: Colors.white,
                  shadowColor: Colors.black.withOpacity(0.5),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Durante la alimentación, la deglución es un proceso involuntario y reflejo que está presente desde el nacimiento. Para que esta se lleve a cabo de manera adecuada, es necesaria la integración de una gran variedad de estructuras que participan en el proceso:',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  '• Óseas.\n'
                  '• Musculares.\n'
                  '• Nerviosas.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  color: Colors.white,
                  shadowColor: Colors.black.withOpacity(0.5),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Que canalizan las sensaciones y los movimientos con la deglución. Consta de tres fases, coordinadas entre ellas y con la respiración: fase oral, fase faríngea y fase esofágica.',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                RawMaterialButton(
                  fillColor: const Color.fromARGB(255, 0, 0, 0),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const EvaluaTemp()));
                  },
                  child: const Text(
                    'Evaluacion',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
