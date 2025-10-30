import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';

class CuentoAudioPage extends StatefulWidget {
  @override
  _CuentoAudioPageState createState() => _CuentoAudioPageState();
}

class _CuentoAudioPageState extends State<CuentoAudioPage> {
  final AudioPlayer _player = AudioPlayer();
  final List<String> _audios = [
    'assets/sonidos/PRIMER CUENTO.mp3',
    'assets/sonidos/SEGUNDO CUENTO.mp3',
    'assets/sonidos/TERCER CUENTO.mp3',
    'assets/sonidos/CUARTO CUENTO.mp3',
    'assets/sonidos/QUINTO_CUENTO.mp3',
     'assets/sonidos/SEXTO_CUENTO.mp3'
  ];

  late String currentAudio;

  @override
  void initState() {
    super.initState();
    _loadRandomAudio();
  }

  Future<void> _loadRandomAudio() async {
    final random = Random();
    currentAudio = _audios[random.nextInt(_audios.length)];
    await _player.setAsset(currentAudio);
    _player.play();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _seekForward() {
    _player.seek(_player.position + Duration(seconds: 10));
  }

  void _seekBackward() {
    _player.seek(_player.position - Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.pink.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  "🎧 Reproductor de Cuentos 🎧",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.black26, offset: Offset(1, 1), blurRadius: 2),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.book_rounded, size: 100, color: Colors.deepPurple),
                        SizedBox(height: 20),
                        Text(
                          "Cuento actual:",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          currentAudio.split('/').last,
                          style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        StreamBuilder<PlayerState>(
                          stream: _player.playerStateStream,
                          builder: (context, snapshot) {
                            final playerState = snapshot.data;
                            final playing = playerState?.playing;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _controlButton(Icons.replay_10, _seekBackward),
                                SizedBox(width: 20),
                                _controlButton(
                                  playing == true ? Icons.pause : Icons.play_arrow,
                                  () {
                                    if (playing == true) {
                                      _player.pause();
                                    } else {
                                      _player.play();
                                    }
                                  },
                                  size: 60,
                                ),
                                SizedBox(width: 20),
                                _controlButton(Icons.forward_10, _seekForward),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Disfruta un cuento nuevo cada vez 📚",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _controlButton(IconData icon, VoidCallback onPressed, {double size = 40}) {
    return ClipOval(
      child: Material(
        color: Colors.deepPurple.withOpacity(0.1),
        child: InkWell(
          splashColor: Colors.deepPurple,
          onTap: onPressed,
          child: SizedBox(
            width: size + 10,
            height: size + 10,
            child: Icon(icon, size: size, color: Colors.deepPurple),
          ),
        ),
      ),
    );
  }
}

