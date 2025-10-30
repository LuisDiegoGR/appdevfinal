import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ActividadAudicionMes2Page extends StatefulWidget {
  const ActividadAudicionMes2Page({Key? key}) : super(key: key);

  @override
  _ActividadAudicionMes2PageState createState() => _ActividadAudicionMes2PageState();
}

class _ActividadAudicionMes2PageState extends State<ActividadAudicionMes2Page> with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _audioActual;
  late AnimationController _controller;
  Duration _duracionTotal = Duration.zero;
  Duration _duracionActual = Duration.zero;

  final List<Map<String, dynamic>> _audios = [
    {
      'archivo': 'lago_cisnes.mp3',
      'titulo': 'Lago de los Cisnes',
      'color': Colors.pinkAccent,
      'icono': Icons.water_drop,
      'imagen': 'assets/images/lago_cisnes.jpg',
    },
    {
      'archivo': 'Pequeña_Serenata_Nocturna.mp3',
      'titulo': 'Pequeña Serenata',
      'color': Colors.orangeAccent,
      'icono': Icons.nightlight_round,
      'imagen': 'assets/images/serenata.jpeg',
    },
    {
      'archivo': 'Chopin.mp3',
      'titulo': 'Chopin',
      'color': Colors.lightGreen,
      'icono': Icons.piano,
      'imagen': 'assets/images/chopin.jpeg',
    },
    {
      'archivo': 'Pedro_y_lobo.mp3',
      'titulo': 'Pedro y el Lobo',
      'color': Colors.cyan,
      'icono': Icons.pets,
      'imagen': 'assets/images/pedro_y_lobo.jpg',
    },
    {
      'archivo': 'El_carnaval_animales.mp3',
      'titulo': 'Carnaval Animales',
      'color': Colors.deepPurpleAccent,
      'icono': Icons.celebration,
      'imagen': 'assets/images/carnaval.png',
    },
     {
      'archivo': 'Escenas_de_niños.mp3',
      'titulo': 'Escenas de Niños',
      'color': Colors.tealAccent,
      'icono': Icons.child_care,
      'imagen': 'assets/images/escena_niños.jpg',
    },
    {
      'archivo': 'El reloj.mp3',
      'titulo': 'El Reloj',
      'color': const Color.fromARGB(255, 209, 83, 5),
      'icono': Icons.child_care,
      'imagen': 'assets/images/EL RELOJ.jpg',
    },
    {
      'archivo': 'Danza Húngara.mp3',
      'titulo': 'Danza Húngara',
      'color': const Color.fromARGB(255, 27, 109, 3),
      'icono': Icons.child_care,
      'imagen': 'assets/images/DANZA HUNGARA.jpg',
    },
 {
      'archivo': 'La Canción de Solveig.mp3',
      'titulo': 'La Canción de Solveig',
      'color': const Color.fromARGB(255, 100, 11, 51),
      'icono': Icons.child_care,
      'imagen': 'assets/images/SOLVEING.jpg',
    },
    {
      'archivo': 'Dvořák-Nuevo_Mundo.mp3',
      'titulo': 'Nuevo Mundo',
      'color': const Color.fromARGB(255, 67, 90, 74),
      'icono': Icons.child_care,
      'imagen': 'assets/images/NEW WORLD.jpg',
    },
    {
      'archivo': 'Bach.mp3',
      'titulo': 'Bach',
      'color': const Color.fromARGB(255, 216, 50, 231),
      'icono': Icons.child_care,
      'imagen': 'assets/images/BACH.jpg',
    },
{
      'archivo': 'Danza delle furie.mp3',
      'titulo': 'Danza delle furie',
      'color': const Color.fromARGB(234, 15, 142, 193),
      'icono': Icons.child_care,
      'imagen': 'assets/images/DELLE FURIE.jpg',
    },
    {
      'archivo': 'Berenice.mp3',
      'titulo': 'Berenice',
      'color': const Color.fromARGB(234, 198, 109, 233),
      'icono': Icons.child_care,
      'imagen': 'assets/images/BERENICE.jpg',
    },
    {
      'archivo': 'Oboe en Re menor.mp3',
      'titulo': 'Oboe en Re menor.',
      'color': const Color.fromARGB(234, 16, 134, 112),
      'icono': Icons.child_care,
      'imagen': 'assets/images/OBOE.jpg',
    },
{
      'archivo': 'Prelude.mp3',
      'titulo': 'Prelude.',
      'color': const Color.fromARGB(234, 110, 62, 214),
      'icono': Icons.child_care,
      'imagen': 'assets/images/PRELLUDE.jpg',
    },
    {
      'archivo': 'Frühlingsstimmen.mp3',
      'titulo': 'Frühlingsstimmen.',
      'color': const Color.fromARGB(234, 6, 85, 47),
      'icono': Icons.child_care,
      'imagen': 'assets/images/Frühlingsstimmen.jpg',
    },
     {
      'archivo': 'La tormenta-Beethoven.mp3',
      'titulo': 'La tormenta de Beethoven',
      'color': const Color.fromARGB(255, 39, 2, 84),
      'icono': Icons.sync_lock,
      'imagen': 'assets/images/bethoven.jpg',
    },
    {
      'archivo': 'Panchebell.mp3',
      'titulo': 'Panchebell-Orquesta Navideña',
      'color': const Color.fromARGB(255, 205, 188, 108),
      'icono': Icons.sync_lock,
      'imagen': 'assets/images/orquesta_navidad.jpg',
    },
     {
      'archivo': 'Intermezzo.mp3',
      'titulo': 'Intermezzo',
      'color': const Color.fromARGB(255, 232, 232, 232),
      'icono': Icons.sync_lock,
      'imagen': 'assets/images/niña.jpg',
    },
    {
      'archivo': 'Italiana.mp3',
      'titulo': 'Italiana',
      'color': const Color.fromARGB(255, 132, 19, 19),
      'icono': Icons.sync_lock,
      'imagen': 'assets/images/italiana2.jpg',
    },

  ];

  Future<void> _reproducirAudio(String archivo) async {
    if (_audioActual == archivo) {
      await _audioPlayer.pause();
      _controller.stop();
      setState(() {
        _audioActual = null;
      });
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sonidos/$archivo'));
      _controller.repeat();
      setState(() {
        _audioActual = archivo;
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _audioPlayer.onPlayerComplete.listen((event) {
      _controller.stop();
      setState(() {
        _audioActual = null;
        _duracionActual = Duration.zero;
      });
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duracionTotal = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _duracionActual = position;
      });
    });
  }

  Future<void> _adelantar10Segundos() async {
    final nuevaPosicion = _duracionActual + const Duration(seconds: 10);
    if (nuevaPosicion < _duracionTotal) {
      await _audioPlayer.seek(nuevaPosicion);
    } else {
      await _audioPlayer.seek(_duracionTotal);
    }
  }

  Future<void> _retroceder10Segundos() async {
    final nuevaPosicion = _duracionActual - const Duration(seconds: 10);
    if (nuevaPosicion > Duration.zero) {
      await _audioPlayer.seek(nuevaPosicion);
    } else {
      await _audioPlayer.seek(Duration.zero);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Rocola Musical 🎵'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: RotationTransition(
              turns: _controller,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade800,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/disco.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.deepPurple.shade400, blurRadius: 12, spreadRadius: 4),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: PageView.builder(
              itemCount: _audios.length,
              controller: PageController(viewportFraction: 0.42),
              itemBuilder: (context, index) {
                final audio = _audios[index];
                final esAudioActual = _audioActual == audio['archivo'];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  padding: const EdgeInsets.all(6),
                  width: 140,
                  decoration: BoxDecoration(
                    color: audio['color'],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 5, spreadRadius: 1),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          audio['imagen'],
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        audio['titulo'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton.icon(
                        onPressed: () => _reproducirAudio(audio['archivo']),
                        icon: Icon(
                          esAudioActual ? Icons.pause_circle : Icons.play_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: Text(
                          esAudioActual ? 'Pausar' : 'Play',
                          style: const TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      if (esAudioActual) ...[
                        Slider(
                          activeColor: Colors.white,
                          inactiveColor: Colors.white30,
                          value: _duracionActual.inSeconds.toDouble().clamp(0, _duracionTotal.inSeconds.toDouble()),
                          min: 0,
                          max: _duracionTotal.inSeconds.toDouble(),
                          onChanged: (value) async {
                            final nuevaPosicion = Duration(seconds: value.toInt());
                            await _audioPlayer.seek(nuevaPosicion);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(_duracionActual),
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                              Text(
                                _formatDuration(_duracionTotal),
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: _retroceder10Segundos,
                              icon: const Icon(Icons.replay_10, color: Colors.white),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: _adelantar10Segundos,
                              icon: const Icon(Icons.forward_10, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}













