import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';

class ActividadAudicionMes3 extends StatefulWidget {
  const ActividadAudicionMes3({Key? key}) : super(key: key);

  @override
  State<ActividadAudicionMes3> createState() => _ActividadAudicionMes3State();
}

class _ActividadAudicionMes3State extends State<ActividadAudicionMes3> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final String actividadPlusUrl = 'https://youtu.be/9gb5OrXFw2k';

  Future<void> _playSound(String soundAsset) async {
    await _audioPlayer.play(AssetSource(soundAsset));
  }

  Future<void> _launchActividadPlus(BuildContext context) async {
    final Uri url = Uri.parse(actividadPlusUrl);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el video de Actividad Plus.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al abrir el video: $e')),
      );
    }
  }

  Widget _buildPianoKey({
    required String label,
    required String soundAsset,
    required Color color,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () => _playSound(soundAsset),
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text('Piano de Instrumentos - Mes 3'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          TextButton.icon(
            onPressed: () => _launchActividadPlus(context),
            icon: const Icon(Icons.play_circle, color: Colors.white),
            label: const Text(
              'Actividad Plus',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Draggable<String>(
              data: 'palito',
              feedback: Image.asset('assets/images/palito.png', width: 80, height: 80),
              childWhenDragging: Opacity(
                opacity: 0.3,
                child: Image.asset('assets/images/palito.png', width: 80, height: 80),
              ),
              child: Image.asset('assets/images/palito.png', width: 80, height: 80),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    _buildPianoKey(
                        label: 'Sonajero',
                        soundAsset: 'sonidos/sonajero.mp3',
                        icon: Icons.music_note,
                        color: Colors.orange),
                    _buildPianoKey(
                        label: 'Xilófono',
                        soundAsset: 'sonidos/xilofono.mp3',
                        icon: Icons.piano,
                        color: Colors.green),
                    _buildPianoKey(
                        label: 'Tambor',
                        soundAsset: 'sonidos/tambor.mp3',
                        icon: Icons.album,
                        color: Colors.blue),
                    _buildPianoKey(
                        label: 'Pandereta',
                        soundAsset: 'sonidos/pandereta.mp3',
                        icon: Icons.circle,
                        color: Colors.purple),
                    _buildPianoKey(
                        label: 'Campana',
                        soundAsset: 'sonidos/campana.mp3',
                        icon: Icons.notifications,
                        color: Colors.redAccent),
                    _buildPianoKey(
                        label: 'Maraca',
                        soundAsset: 'sonidos/maracas.mp3',
                        icon: Icons.rice_bowl,
                        color: Colors.teal),
                    _buildPianoKey(
                        label: 'Flauta',
                        soundAsset: 'sonidos/flauta.mp3',
                        icon: Icons.air,
                        color: Colors.cyan),
                    _buildPianoKey(
                        label: 'Triángulo',
                        soundAsset: 'sonidos/triangulo.mp3',
                        icon: Icons.change_history,
                        color: Colors.amber),
                    _buildPianoKey(
                        label: 'Cascabel',
                        soundAsset: 'sonidos/cascabeles.mp3',
                        icon: Icons.snowing,
                        color: Colors.indigo),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}





