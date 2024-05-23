import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class PageEstimulacion extends StatefulWidget {
  @override
  _PageEstimulacionState createState() => _PageEstimulacionState();
}

class _PageEstimulacionState extends State<PageEstimulacion> {
  double _progress = 0.0;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _loadProgress();

    // Inicializar el controlador del video
    _controller = VideoPlayerController.asset(
      'assets/videos/PruebaVideo.mp4', // Reemplaza con el nombre de tu archivo de video
    );

    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {}); // Actualizar el estado para que se muestre el video
    });

    // Escuchar el evento de finalización del video
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _completeVideo();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Cargar el progreso del usuario
  _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _progress = (prefs.getDouble('progress') ?? 0.0);
    });
  }

  // Guardar el progreso del usuario
  _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('progress', _progress);
  }

  // Resetear el progreso del usuario
  _resetProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _progress = 0.0;
    });
    prefs.setDouble('progress', _progress);
  }

  // Marcar el video como completado
  void _completeVideo() {
    setState(() {
      _progress = 1.0;
    });
    _saveProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenidos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¡Bienvenidos a la sección de Estimulación Temprana!',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _progress,
              minHeight: 10,
            ),
            SizedBox(height: 20),
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _resetProgress();
              },
              child: Text('Resetear Progreso'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: PageEstimulacion(),
));
