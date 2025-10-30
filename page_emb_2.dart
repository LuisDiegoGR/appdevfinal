import 'package:flutter/material.dart';
import 'package:appdevfinal/page_emb_3.dart';
import 'package:appdevfinal/page_embarazo.dart';

class PageEmb2 extends StatefulWidget {
  const PageEmb2({super.key});

  @override
  State<PageEmb2> createState() => _PageEmb2State();
}

class _PageEmb2State extends State<PageEmb2> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Detectar tipo de dispositivo
    final bool isTablet = size.width >= 600 && size.width < 1024;
    final bool isDesktop = size.width >= 1024;
    final bool isMobile = size.width < 600;

    // Altura de imagen adaptativa
    final double imageHeight = isDesktop
        ? size.height * 0.65
        : isTablet
            ? size.height * 0.45
            : size.height * 0.32;

    // Ajuste del modo de imagen
    final BoxFit imageFit = isMobile ? BoxFit.cover : BoxFit.cover;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.pink[100],
          title: const Text(
            'Segunda Sección',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => PageEmbarazo()),
              );
            },
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Imagen adaptativa superior
            SizedBox(
              width: double.infinity,
              height: imageHeight,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                child: Image.asset(
                  'assets/images/fondo_emb2.jpg',
                  fit: imageFit,
                  alignment: isMobile
                      ? Alignment.center
                      : isTablet
                          ? Alignment.center
                          : Alignment.center,
                ),
              ),
            ),

            // Contenido principal
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFF0F0), Color(0xFFFFFAFA)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(20.0),
                  children: [
                    _buildSectionCard(
                      title: 'NUTRICIÓN',
                      content:
                          'El cuidado nutricional durante el embarazo es esencial para garantizar un desarrollo saludable del bebé y el bienestar de la madre.',
                      icon: Icons.pregnant_woman,
                      backgroundColor: Colors.pink[50]!,
                      items: [
                        'El ácido fólico previene defectos del tubo neural y problemas cardíacos.',
                        'Las embarazadas pueden necesitar hasta 1,000 mg de calcio diario.',
                        'El hierro mejora la oxigenación del bebé y previene anemia.',
                        'Hidrátate con al menos 2.3 litros de agua al día.',
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSectionCard(
                      title: 'SALUD MÉDICA',
                      content:
                          'Las revisiones médicas constantes y la prevención de enfermedades son fundamentales durante el embarazo.',
                      icon: Icons.local_hospital,
                      backgroundColor: Colors.green[50]!,
                      items: [
                        'Asiste a tus consultas prenatales para monitorear la salud.',
                        'Realiza tamizajes para ITS y bacteriuria.',
                        'Vacúnate contra la influenza y el toxoide tetánico.',
                        'Visita al dentista para evitar problemas periodontales.',
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSectionCard(
                      title: 'SALUD MENTAL',
                      content:
                          'El bienestar emocional es tan importante como la salud física durante el embarazo.',
                      icon: Icons.psychology,
                      backgroundColor: Colors.blue[50]!,
                      items: [
                        'El cerebro cambia para fortalecer el vínculo con el bebé.',
                        'Hablarle al bebé estimula su desarrollo cognitivo.',
                        'Evita el estrés crónico, puede afectar al bebé.',
                        'Practica meditación o mindfulness diariamente.',
                      ],
                    ),
                    const SizedBox(height: 30),
                    _buildFloatingButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tarjetas de secciones
  Widget _buildSectionCard({
    required String title,
    required String content,
    required IconData icon,
    required Color backgroundColor,
    List<String>? items,
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, 30 * (1 - _fadeAnimation.value)),
        child: Opacity(opacity: _fadeAnimation.value, child: child),
      ),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.black54, size: 26),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                content,
                style: const TextStyle(fontSize: 16, color: Colors.black54, height: 1.4),
              ),
              if (items != null) ...[
                const SizedBox(height: 16),
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_outline, color: Colors.black45, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  // Botón inferior
  Widget _buildFloatingButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => RuletaPage()),
          );
        },
        icon: const Icon(Icons.arrow_forward, color: Colors.white),
        label: const Text(
          'Continuar',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink[300],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 4,
        ),
      ),
    );
  }
}







































