import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'actividades.dart'; // Importa tu archivo actividades.dart aquí

class InfografiaPage extends StatefulWidget {
  final VoidCallback onCompleted;

  const InfografiaPage({Key? key, required this.onCompleted}) : super(key: key);

  @override
  _InfografiaPageState createState() => _InfografiaPageState();
}

class _InfografiaPageState extends State<InfografiaPage> {
  late VideoPlayerController _controller;
  bool _isCompleted = false;
  bool _isImageLoaded = false;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/Tecnica_estimulacion11.mp4')
      ..initialize().then((_) {
        setState(() {}); // Actualiza el estado cuando el video esté inicializado
      });
    _controller.setLooping(false);
    _loadPreferences(); // Carga las preferencias al iniciar la página
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  void _rewind() {
    final currentPosition = _controller.value.position;
    _controller.seekTo(currentPosition - const Duration(seconds: 10));
  }

  void _fastForward() {
    final currentPosition = _controller.value.position;
    _controller.seekTo(currentPosition + const Duration(seconds: 10));
  }

  void _restartVideo() {
    _controller.seekTo(Duration.zero);
    _controller.play();
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _imagePath = result.files.single.path;
        _isImageLoaded = true; // Imagen cargada
        _isCompleted = true; // Desbloquea el botón "Marcar como completado"
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Imagen cargada: ${result.files.single.name}'),
          backgroundColor: Colors.lightBlueAccent,
        ),
      );
      _savePreferences(); // Guarda las preferencias después de cargar la imagen
    }
  }

  void _removeImage() {
    setState(() {
      _imagePath = null;
      _isCompleted = false; // Bloquea el botón "Marcar como completado"
      _isImageLoaded = false;
    });
    _savePreferences(); // Guarda las preferencias después de eliminar la imagen
  }

  void _onComplete() {
    widget.onCompleted();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ActividadesPage()), // Redirige a ActividadesPage
    );
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('imagePath');
      _isImageLoaded = _imagePath != null;
      _isCompleted = prefs.getBool('isCompleted') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', _imagePath ?? '');
    await prefs.setBool('isCompleted', _isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '✨ Técnica de Estimulación ✨',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.deepPurple.shade800,
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.purpleAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF240046),
              Color(0xFF5A189A),
              Color(0xFFD8B4E2),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_controller.value.isInitialized)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purpleAccent.withOpacity(0.6),
                              blurRadius: 20,
                              spreadRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          border: Border.all(color: Colors.purpleAccent, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: 180,
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.replay_10),
                            color: Colors.pinkAccent,
                            iconSize: 30,
                            onPressed: _rewind,
                          ),
                          IconButton(
                            icon: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                            color: Colors.yellowAccent,
                            iconSize: 40,
                            onPressed: _togglePlayPause,
                          ),
                          IconButton(
                            icon: const Icon(Icons.forward_10),
                            color: Colors.pinkAccent,
                            iconSize: 30,
                            onPressed: _fastForward,
                          ),
                          IconButton(
                            icon: const Icon(Icons.replay),
                            color: Colors.blueAccent,
                            iconSize: 30,
                            onPressed: _restartVideo,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadowColor: Colors.purpleAccent,
                          elevation: 8,
                        ),
                        onPressed: _pickImage,
                        child: const Text(
                          'Subir Imagen',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_imagePath != null)
                        Column(
                          children: [
                            Text('Imagen cargada: ${_imagePath!.split('/').last}', style: TextStyle(color: Colors.purpleAccent, fontSize: 16)),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _isImageLoaded ? _removeImage : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Eliminar Imagen',
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                    ],
                  )
                else
                  const CircularProgressIndicator(
                    color: Colors.purpleAccent,
                  ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: const [
                      Text(
                        "Importancia de las Técnicas de Estimulación en Recién Nacidos",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9A6EFF),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Las técnicas de estimulación en recién nacidos son fundamentales para el desarrollo motor y sensorial de los bebés. Ayudan a fortalecer los músculos, mejorar la coordinación y estimular los sentidos, lo que contribuye a un crecimiento saludable. Al aplicar estas técnicas de manera regular, se puede promover el bienestar general del bebé y reducir problemas de desarrollo a largo plazo.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.purpleAccent),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isCompleted ? Colors.deepPurpleAccent : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.purpleAccent,
                    elevation: 8,
                  ),
                  onPressed: _isCompleted ? _onComplete : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check, color: Colors.white, size: 24),
                      SizedBox(width: 10),
                      Text(
                        'Marcar como completado',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




















