import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'balbuceos.dart';

class ActividadAudicionMes5 extends StatefulWidget {
  const ActividadAudicionMes5({super.key});

  @override
  State<ActividadAudicionMes5> createState() => _ActividadAudicionMes5State();
}

class _ActividadAudicionMes5State extends State<ActividadAudicionMes5> {
  final Map<String, Alignment> estaciones = {
    'Granja': Alignment(-0.8, 0.8),
    'Selva': Alignment(0.0, 0.8),
    'Ciudad': Alignment(-0.8, -0.9),
    'Océano': Alignment(-0.9, -0.0),
    'Sabana': Alignment(0.9, 0.2),
    'Bosque': Alignment(0.6, -0.4),
  };

  Alignment _posicionTren = Alignment(-0.9, -0.8);
  bool _animando = false;
  bool _invertido = false; // Controla si la imagen está invertida

  void _moverTrenYIr(BuildContext context, String estacion) async {
    if (_animando) return;

    Alignment nuevaPos = estaciones[estacion]!;
    setState(() {
      _invertido = nuevaPos.x > _posicionTren.x;
      _posicionTren = nuevaPos;
      _animando = true;
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() => _animando = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EstacionSonidosPage(estacion: estacion),
      ),
    );
  }

  void _irABalbuceos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BalbuceosPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa del Tesoro Sonoro'),
        backgroundColor: Colors.brown,
      ),
      body: Stack(
        children: [
          // Fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/mapa2.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Subtítulo flotante arriba
          Positioned(
            top: 10,
            left: 20,
            right: 20,
            child: Card(
              color: Colors.white.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Viaja a través del mapa para conocer los sonidos",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown.shade800,
                  ),
                ),
              ),
            ),
          ),

          // Estaciones interactivas
          ...estaciones.entries.map((entry) {
            return Align(
              alignment: entry.value,
              child: GestureDetector(
                onTap: () => _moverTrenYIr(context, entry.key),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/icono_${entry.key.toLowerCase()}.jpg',
                      width: 60,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(entry.key),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),

          // Animación del avión/tren
          AnimatedAlign(
            alignment: _posicionTren,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(_invertido ? -1.0 : 1.0, 1.0),
              child: Image.asset(
                'assets/images/AVION2.png',
                width: 80,
              ),
            ),
          ),

          // Botón extra inferior
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: _irABalbuceos,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.brown,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EstacionSonidosPage extends StatefulWidget {
  final String estacion;

  const EstacionSonidosPage({super.key, required this.estacion});

  @override
  State<EstacionSonidosPage> createState() => _EstacionSonidosPageState();
}

class _EstacionSonidosPageState extends State<EstacionSonidosPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? mensaje;

  final Map<String, List<Map<String, String>>> sonidos = {
    'Granja': [
      {'title': 'Vaca', 'file': 'vaca.mp3'},
      {'title': 'Gallina', 'file': 'gallina.mp3'},
      {'title': 'Cerdo', 'file': 'cerdo.mp3'},
      {'title': 'Cabra', 'file': 'Cabra.mp3'},
      {'title': 'Caballo', 'file': 'Caballo.mp3'},
      {'title': 'Gallo', 'file': 'Gallo.mp3'},
      {'title': 'Oveja', 'file': 'Oveja.mp3'},
    ],
    'Selva': [
      {'title': 'Mono', 'file': 'mono.mp3'},
      {'title': 'Jaguar', 'file': 'jaguar.mp3'},
      {'title': 'Gorila', 'file': 'Gorilla.mp3'},
      {'title': 'Tigre', 'file': 'Tigre.mp3'},
      {'title': 'Pantera', 'file': 'Pantera.mp3'},
      {'title': 'Guacamaya', 'file': 'Guacamaya.mp3'},
      {'title': 'Serpiente', 'file': 'Serpiente.mp3'},
      {'title': 'Tapir', 'file': 'Tapir.mp3'},
    ],
    'Ciudad': [
      {'title': 'Perro', 'file': 'perro.mp3'},
      {'title': 'Gato', 'file': 'gato.mp3'},
      {'title': 'Claxon', 'file': 'Claxon.mp3'},
      {'title': 'Timbre', 'file': 'Timbre.mp3'},
      {'title': 'Helicoptero', 'file': 'Helicoptero.mp3'},
    ],
    'Océano': [
      {'title': 'Ballena', 'file': 'Ballena_Azul.mp3'},
      {'title': 'Gaviota', 'file': 'Gaviota.mp3'},
      {'title': 'Olas del mar', 'file': 'Olas del mar.mp3'},
      {'title': 'Orca', 'file': 'Orca.mp3'},
      {'title': 'Delfin', 'file': 'Delfin.mp3'},
      {'title': 'Foca', 'file': 'Foca.mp3'},
    ],
    'Sabana': [
      {'title': 'Elefante', 'file': 'Elefante.mp3'},
      {'title': 'León', 'file': 'Leon.mp3'},
      {'title': 'Zebra', 'file': 'Zebra.mp3'},
      {'title': 'Buitre', 'file': 'Buitre.mp3'},
      {'title': 'Guepardo', 'file': 'Guepardo.mp3'},
      {'title': 'Bufalo', 'file': 'Bufalo.mp3'},
    ],
    'Bosque': [
      {'title': 'Oso', 'file': 'Oso.mp3'},
      {'title': 'Puma', 'file': 'Puma.mp3'},
      {'title': 'Conejo', 'file': 'Conejo.mp3'},
      {'title': 'Ardilla', 'file': 'Ardilla.mp3'},
      {'title': 'Pajaro Carpintero', 'file': 'Pajaro Carpintero.mp3'},
    ],
  };

  void _reproducir(String file) async {
  await _audioPlayer.stop();
  await _audioPlayer.play(AssetSource('sonidos/$file'));

  // Detener el audio después de 5 segundos
  Future.delayed(const Duration(seconds: 5), () {
    _audioPlayer.stop();
  });

  setState(() {
    mensaje =
        "Presiona cualquier botón, escucha el sonido e imítalo para que tu bebé empiece a socializarse con los sonidos.";
  });
}


  @override
  Widget build(BuildContext context) {
    final sonidosEstacion = sonidos[widget.estacion] ?? [];
    final String estacion = widget.estacion;

    // Fondos por estación
    final Map<String, String> fondos = {
      'Océano': 'assets/images/animales_oceano.jpg',
      'Selva': 'assets/images/SELVA.png',
      'Granja': 'assets/images/granja.png',
      'Ciudad': 'assets/images/ciudad.png',
      'Bosque': 'assets/images/bosque.png',
      'Sabana': 'assets/images/sabana.png',
    };

    final String? fondo = fondos[estacion];

    return Scaffold(
      appBar: AppBar(
        title: Text('Estación: $estacion'),
        backgroundColor: Colors.brown,
      ),
      body: Stack(
        children: [
          if (fondo != null)
            Positioned.fill(
              child: Image.asset(
                fondo,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(color: Colors.amber.shade50),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/icono_${estacion.toLowerCase()}.jpg',
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: sonidosEstacion.map((sonido) {
                        return ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown.shade300,
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.music_note),
                          label: Text(sonido['title']!),
                          onPressed: () => _reproducir(sonido['file']!),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        border: Border.all(color: Colors.brown, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        mensaje ?? "Presiona un botón para comenzar",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

