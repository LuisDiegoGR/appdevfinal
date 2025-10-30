import 'dart:async';
import 'package:flutter/material.dart';

class LlantosPage extends StatefulWidget {
  const LlantosPage({Key? key}) : super(key: key);

  @override
  State<LlantosPage> createState() => _LlantosPageState();
}

class _LlantosPageState extends State<LlantosPage> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  late Timer _consejoTimer;
  int _consejoIndex = 0;
  String consejoDelDia = '';

  // Para el botón animado
  late AnimationController _btnColorController;
  late Animation<Color?> _btnColorAnimation;

  // Lista dinámica de llantos con hora y emoji
  final List<_LlantoEntry> _llantosDelDia = [];

  // Lista de consejos generales
  final List<String> consejos = [
    "Confía en tu intuición como madre o padre.",
    "No todos los llantos significan lo mismo, observa con calma.",
    "El contacto piel con piel puede calmar a tu bebé.",
    "Tu voz y tu mirada también consuelan.",
    "Los bebés también lloran por exceso de estímulo."
  ];

  // Colores pastel para fondo que van rotando
  final List<Color> _fondoColores = [
    const Color(0xFFFFF4F4),
    const Color(0xFFFEF9F9),
    const Color(0xFFFEEEF1),
    const Color(0xFFFFF0F5),
  ];
  late Timer _fondoTimer;
  int _fondoIndex = 0;
  Color _colorFondoActual = const Color(0xFFFFF4F4);

  List<Widget> _emojis = [];

  @override
  void initState() {
    super.initState();

    // Consejo inicial
    _consejoIndex = DateTime.now().day % consejos.length;
    consejoDelDia = consejos[_consejoIndex];

    // Animación flotante
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Cambiar consejo cada 10 segundos
    _consejoTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      setState(() {
        _consejoIndex = (_consejoIndex + 1) % consejos.length;
        consejoDelDia = consejos[_consejoIndex];
      });
    });

    // Animación color botón
    _btnColorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _btnColorAnimation = ColorTween(
      begin: Colors.pink.shade200,
      end: Colors.pink.shade400,
    ).animate(_btnColorController);

    // Fondo cambia color pastel cada 12 segundos
    _colorFondoActual = _fondoColores[0];
    _fondoTimer = Timer.periodic(const Duration(seconds: 12), (_) {
      setState(() {
        _fondoIndex = (_fondoIndex + 1) % _fondoColores.length;
        _colorFondoActual = _fondoColores[_fondoIndex];
      });
    });

    // Emoji bebé que aparece y desaparece
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _emojis.add(_PeekabooEmoji(key: UniqueKey()));
        });
      }
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
    _consejoTimer.cancel();
    _btnColorController.dispose();
    _fondoTimer.cancel();
    super.dispose();
  }

  // Función para agregar llanto y mostrar consejo específico
  void _agregarNuevoLlanto() {
    Map<String, String> tipoLlantoEmojis = {
      'Hambre': '😢',
      'Sueño': '😴',
      'Dolor': '🤕',
      'Pañal sucio': '💩',
      'Aburrimiento': '😐',
    };

    Map<String, String> consejosEspecificos = {
      'Hambre': 'Ofrécele alimento y manténlo cómodo.',
      'Sueño': 'Busca un lugar tranquilo y oscuro para ayudarlo a dormir.',
      'Dolor': 'Revisa si algo le incomoda o si necesita atención médica.',
      'Pañal sucio': 'Cambia el pañal para mayor comodidad.',
      'Aburrimiento': 'Intenta distraerlo con juegos o cantándole suavemente.',
    };

    showDialog(
      context: context,
      builder: (context) {
        String? tipoSeleccionado;
        return StatefulBuilder(
          builder: (context, setStateSB) {
            return AlertDialog(
              title: const Text('Agregar tipo de llanto'),
              content: DropdownButton<String>(
                hint: const Text('Selecciona tipo de llanto'),
                value: tipoSeleccionado,
                isExpanded: true,
                items: tipoLlantoEmojis.keys.map((tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo,
                    child: Text('$tipo ${tipoLlantoEmojis[tipo]}'),
                  );
                }).toList(),
                onChanged: (val) => setStateSB(() => tipoSeleccionado = val),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar')),
                ElevatedButton(
                    onPressed: tipoSeleccionado == null
                        ? null
                        : () {
                            final ahora = TimeOfDay.now();
                            setState(() {
                              _llantosDelDia.add(_LlantoEntry(
                                tipo: tipoSeleccionado!,
                                emoji: tipoLlantoEmojis[tipoSeleccionado!]!,
                                hora: '${ahora.format(context)}',
                              ));
                            });
                            Navigator.pop(context);

                            final consejo = consejosEspecificos[tipoSeleccionado!] ??
                                "Observa y calma con paciencia a tu bebé.";
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Text("Consejo para calmar el llanto de $tipoSeleccionado"),
                                content: Text(consejo),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cerrar"),
                                  )
                                ],
                              ),
                            );
                          },
                    child: const Text('Agregar')),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorFondoActual,
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarNuevoLlanto,
        backgroundColor: Colors.pink.shade300,
        child: const Icon(Icons.add),
        tooltip: "Agregar nuevo llanto",
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _customAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("¿Por qué llora mi bebé?", Icons.question_answer_outlined),
                      const SizedBox(height: 12),
                      _floatingLlantoCard(
                        "Hambre",
                        Icons.fastfood,
                        "Llanto rítmico y constante. Ofrécele alimento.",
                      ),
                      _floatingLlantoCard(
                        "Sueño",
                        Icons.bedtime,
                        "Llanto suave que aumenta gradualmente. Busca un lugar tranquilo.",
                      ),
                      _floatingLlantoCard(
                        "Dolor",
                        Icons.warning_amber_rounded,
                        "Llanto agudo y fuerte. Revisa si algo le incomoda.",
                      ),
                      const SizedBox(height: 30),

                      _adviceBanner(),

                      const SizedBox(height: 24),

                      AnimatedBuilder(
                        animation: _btnColorAnimation,
                        builder: (context, child) => ElevatedButton.icon(
                          icon: const Icon(Icons.library_books),
                          label: const Text("Ver todos los consejos"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _btnColorAnimation.value,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 10,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: const Text(
                                  "Consejos para Calmar los Llantos",
                                  style: TextStyle(color: Colors.pink),
                                ),
                                content: Text("• ${consejos.join("\n• ")}"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cerrar"),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      _sectionTitle("Colección de llantos", Icons.list_alt_outlined),
                      const SizedBox(height: 12),

                      if (_llantosDelDia.isEmpty)
                        const Text("No se han registrado llantos hoy.",
                            style: TextStyle(fontSize: 16)),
                      ..._llantosDelDia.map((llanto) => ListTile(
                            leading: Text(llanto.emoji,
                                style: const TextStyle(fontSize: 26)),
                            title: Text(llanto.tipo,
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold)),
                            trailing: Text(llanto.hora,
                                style: const TextStyle(color: Colors.grey)),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ..._emojis,
        ],
      ),
    );
  }

  SliverAppBar _customAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 160,
      backgroundColor: Colors.pink.shade100,
      flexibleSpace: const FlexibleSpaceBar(
        title: Text("Tipos de llanto"),
        titlePadding: EdgeInsets.only(left: 20, bottom: 16),
      ),
    );
  }

  Widget _sectionTitle(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.pink.shade300),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _floatingLlantoCard(String titulo, IconData icono, String descripcion) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_floatAnimation.value),
          child: Card(
            elevation: 3,
            color: Colors.pink.shade50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icono, size: 32, color: Colors.pink.shade300),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(titulo,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(descripcion, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _adviceBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Consejo del día: $consejoDelDia',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _LlantoEntry {
  final String tipo;
  final String emoji;
  final String hora;

  _LlantoEntry({
    required this.tipo,
    required this.emoji,
    required this.hora,
  });
}

class _PeekabooEmoji extends StatefulWidget {
  const _PeekabooEmoji({Key? key}) : super(key: key);

  @override
  State<_PeekabooEmoji> createState() => _PeekabooEmojiState();
}

class _PeekabooEmojiState extends State<_PeekabooEmoji>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _animation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, 1.5),
          end: const Offset(0, 0.2),
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: const Offset(0, 1.5),
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);

    _controller.forward().whenComplete(() {
      if (mounted) {
        final parent = context.findAncestorStateOfType<_LlantosPageState>();
        parent?._emojis.removeWhere((e) => e.key == widget.key);
        parent?.setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: MediaQuery.of(context).size.width / 2 - 20,
      child: SlideTransition(
        position: _animation,
        child: const Text(
          '👶',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}




