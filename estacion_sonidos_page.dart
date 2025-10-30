import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class EstacionSonidosPage extends StatefulWidget {
  final String estacion;

  const EstacionSonidosPage({super.key, required this.estacion});

  @override
  State<EstacionSonidosPage> createState() => _EstacionSonidosPageState();
}

class _EstacionSonidosPageState extends State<EstacionSonidosPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? mensaje;

  final Map<String, List<Map<String, String>>> sonidosPorEstacion = {
    'Granja': [
      {'title': 'Vaca', 'file': 'vaca.mp3'},
      {'title': 'Gallina', 'file': 'gallina.mp3'},
      {'title': 'Cerdo', 'file': 'cerdo.mp3'},
    ],
    'Selva': [
      {'title': 'Mono', 'file': 'mono.mp3'},
      {'title': 'Jaguar', 'file': 'jaguar.mp3'},
      {'title': 'Loro', 'file': 'loro.mp3'},
    ],
    'Ciudad': [
      {'title': 'Perro', 'file': 'perro.mp3'},
      {'title': 'Gato', 'file': 'gato.mp3'},
      {'title': 'Claxon', 'file': 'claxon.mp3'},
    ],
  };

  final Map<String, Color> colores = {
    'Granja': Colors.orange,
    'Selva': Colors.green,
    'Ciudad': Colors.grey,
  };

  void _reproducirSonido(String archivo) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sonidos/$archivo'));

    setState(() {
      mensaje =
          'PRESIONA CUALQUIER BOTÓN, ESCUCHA EL SONIDO E IMÍTALO PARA QUE TU BEBÉ EMPIECE A SOCIALIZARSE CON LOS SONIDOS';
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sonidos = sonidosPorEstacion[widget.estacion] ?? [];
    final Color colorFondo = colores[widget.estacion] ?? Colors.blueGrey;

    return Scaffold(
      backgroundColor: colorFondo.withOpacity(0.1),
      appBar: AppBar(
        title: Text('Estación: ${widget.estacion}'),
        backgroundColor: colorFondo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Hero(
              tag: widget.estacion,
              child: Image.asset(
                'assets/images/${widget.estacion.toLowerCase()}.jpg',
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Toca un sonido',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: sonidos
                  .map((sonido) => ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorFondo,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _reproducirSonido(sonido['file']!),
                        icon: Icon(Icons.volume_up),
                        label: Text(sonido['title']!),
                      ))
                  .toList(),
            ),
            SizedBox(height: 30),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: colorFondo, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                mensaje ??
                    'Presiona un botón para comenzar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: mensaje != null ? FontWeight.bold : FontWeight.normal,
                  fontStyle: mensaje == null ? FontStyle.italic : FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
