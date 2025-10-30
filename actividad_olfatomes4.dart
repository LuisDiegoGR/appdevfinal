import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:animate_do/animate_do.dart';

class ActividadOlfatoMes4 extends StatefulWidget {
  const ActividadOlfatoMes4({Key? key}) : super(key: key);

  @override
  _ActividadOlfatoMes4State createState() => _ActividadOlfatoMes4State();
}

class _ActividadOlfatoMes4State extends State<ActividadOlfatoMes4> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/Mes4_Olfato.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          // Fondo degradado suave
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF9575CD), Color(0xFFE1BEE7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Video con zoom
          InteractiveViewer(
            panEnabled: true,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            minScale: 0.8,
            maxScale: 5.0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: _controller.value.isInitialized
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),

          // AppBar personalizada
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade700,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Actividad Olfato Mes 4',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Tarjeta flotante con animación y texto
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: BounceInDown(
              duration: const Duration(milliseconds: 700),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.deepPurple, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '✨ Realiza esta actividad, sigue los pasos ✨',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Botón para detener/poner en pausa
          Positioned(
            bottom: 40,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
              label: Text(
                _isPlaying ? 'Detener' : 'Reproducir',
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: togglePlayPause,
            ),
          ),
        ],
      ),
    );
  }
}

