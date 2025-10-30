import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadDesarrollomotrizMes3 extends StatefulWidget {
  @override
  _ActividadDesarrollomotrizMes3State createState() => _ActividadDesarrollomotrizMes3State();
}

class _ActividadDesarrollomotrizMes3State extends State<ActividadDesarrollomotrizMes3> {
  late VideoPlayerController _controller;
  bool _isFullScreen = false;

  // Video de YouTube externo
  final String videoUrl = 'https://www.youtube.com/watch?v=pa1DmWaITF4';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/Mes3_DesarrolloMotriz1.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.seekTo(Duration.zero);
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rewind10Seconds() {
    final newPosition = _controller.value.position - Duration(seconds: 10);
    _controller.seekTo(newPosition < Duration.zero ? Duration.zero : newPosition);
    if (!_controller.value.isPlaying) _controller.play();
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  Future<void> _launchYouTubeVideo() async {
    final Uri url = Uri.parse(videoUrl);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el video en YouTube.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al abrir el video: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen
          ? null
          : AppBar(
              title: const Text('Actividad Desarrollo Motriz - Mes 3'),
              backgroundColor: Color(0xFF87CEEB),
              centerTitle: true,
              elevation: 0,
            ),
      backgroundColor: Color(0xFFF5F5F5),
      body: _isFullScreen
          ? Stack(
              children: [
                GestureDetector(
                  onTap: _toggleFullScreen,
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: Colors.black,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: FloatingActionButton(
                    onPressed: _toggleFullScreen,
                    backgroundColor: Color(0xFF87CEEB),
                    child: const Icon(Icons.fullscreen_exit, color: Colors.white),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _controller.value.isInitialized
                        ? AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [Color(0xFFB0E0E6), Color(0xFFADD8E6)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                            ),
                          )
                        : const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF87CEEB)),
                          ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.replay_10, size: 36, color: Color(0xFF87CEEB)),
                          onPressed: _rewind10Seconds,
                        ),
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 36,
                            color: Color(0xFF87CEEB),
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying ? _controller.pause() : _controller.play();
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                            size: 36,
                            color: Color(0xFF87CEEB),
                          ),
                          onPressed: _toggleFullScreen,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Desarrollo Motriz - Mes 3',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF87CEEB),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Video para estimular el desarrollo motriz en tu bebé.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF87CEEB).withOpacity(0.75),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // Botón para abrir video en YouTube externo
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                        backgroundColor: Color(0xFF87CEEB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                      ),
                      onPressed: _launchYouTubeVideo,
                      icon: const Icon(Icons.play_circle_fill, color: Colors.white, size: 28),
                      label: const Text(
                        'Ver en YouTube',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}


