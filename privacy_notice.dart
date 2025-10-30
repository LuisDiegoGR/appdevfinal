import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyNoticePage extends StatefulWidget {
  @override
  _PrivacyNoticePageState createState() => _PrivacyNoticePageState();
}

class _PrivacyNoticePageState extends State<PrivacyNoticePage> {
  bool isRead = false;

  Future<void> _launchURL() async {
    final Uri url = Uri.parse('http://www.hraei.salud.gob.mx');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se puede abrir la URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4FB),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 3,
        centerTitle: true,
        title: const Text(
          'Consentimiento Informado',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen del hospital centrada arriba (tamaño original)
                Center(
                  child: Image.asset(
                    'assets/images/logo_hosp1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 15),

                // Título principal
                const Center(
                  child: Text(
                    'AVISO DE PRIVACIDAD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Contenido principal
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F0FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        """
El Investigador principal del Protocolo/Tesis de Investigación es el responsable del tratamiento de los datos personales y datos personales sensibles que usted proporcione con motivo de la participación en un protocolo de Investigación. 

Dichos datos serán tratados estadísticamente en materia de salud, sin vulnerar su identidad mediante el proceso de disociación, con el fin de proteger la identificación de los mismos. 

Todo ello conforme a los artículos 1, 2, 3, 8, 16, 17, 18, fracción VII del 22, 26, 27 y demás relativos de la Ley General de Protección de Datos Personales en Posesión de Sujetos Obligados.

Puede consultar más información en el Portal Institucional:
""",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Enlace al portal
                Center(
                  child: GestureDetector(
                    onTap: _launchURL,
                    child: const Text(
                      '➡ http://www.hraei.salud.gob.mx',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Checkbox y texto
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.deepPurple,
                      value: isRead,
                      onChanged: (value) {
                        setState(() {
                          isRead = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'He leído y acepto la información presentada.',
                        style: TextStyle(fontSize: 15.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Botón de confirmar
                Center(
                  child: ElevatedButton.icon(
                    onPressed: isRead
                        ? () {
                            Navigator.pop(context, true);
                          }
                        : null,
                    icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                    label: const Text(
                      'Marcar como leído',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                      disabledBackgroundColor: Colors.deepPurple.shade200,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}