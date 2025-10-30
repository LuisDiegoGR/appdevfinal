import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class GeminiChatBot extends StatefulWidget {
  const GeminiChatBot({super.key});

  @override
  State<GeminiChatBot> createState() => _GeminiChatBotState();
}

class _GeminiChatBotState extends State<GeminiChatBot> {
  final TextEditingController promptController = TextEditingController();
  static const apiKey = "AIzaSyAgyh3K5i2TrlikmbD7tWS7y-OUfUKjqMw";
  final List<ModelMessage> prompt = [];
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
    WidgetsBinding.instance.addPostFrameCallback((_) => _mostrarAvisoInicial());
  }

  void _mostrarAvisoInicial() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFDE2E4), Color(0xFFE0F7FA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/gifs/NEOBOT.gif",
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "¡Hola! Soy NEOBOT 🤖",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0288D1),
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Soy tu asistente virtual en estimulación temprana y desarrollo infantil.\n\n"
                "⚠️ Mis respuestas son sugerencias y nunca sustituyen la consulta médica.",
                style: TextStyle(color: Colors.black87, fontSize: 15, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0288D1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text("¡Entendido!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isRelevant(String message) {
final greetings = [
  "hola", "buenos días", "buenas tardes", "buenas noches", "qué tal",
  "saludos", "cómo estás", "hey", "hi", "holi", "buen día", "qué onda",
  "qué hubo", "qué pasa", "qué hay", "hola", "bebe", "bb", "peque",
  "saluditos", "holaaa", "hey baby", "qué tal ", "hola pequeño"
];

final farewells = [
  "adiós", "gracias", "hasta luego", "nos vemos", "bye", "chao", 
  "me despido", "cuidate", "adios bb", "hasta pronto", "nos vemos luego",
  "bye bye", "chau", "goodbye", "see you", "hasta mañana", "hasta la vista"
];

final topics = [
  // Estimulación temprana y desarrollo
  "estimulación temprana", "estimulación precoz", "estimulación integral", "estimulación sensorial",
  "estimulación motriz", "estimulación motora", "estimulación cognitiva", "estimulación visual",
  "estimulación auditiva", "estimulación oral", "estimulación del lenguaje", "estimulación manual",
  "estimulación táctil", "estimulación infantil", "estimulación bebé", "estimulación bb",
  "estimulación motriz bb", "estimulación lenguaje bb", "estimulación psicomotriz",

  // Rehabilitación pediátrica
  "rehabilitación pediátrica", "rehabilitación infantil", "rehabilitación temprana",
  "rehabilitación bb", "rehabilitación bebé", "intervención temprana", "intervención pediátrica",
  "terapia pediátrica", "terapia de juego", "terapia ocupacional", "fisioterapia pediátrica",
  "fonoaudiología", "logopedia", "rehabilitación neurológica infantil", "estimulación terapéutica",

  // Desarrollo del bebé y habilidades
  "desarrollo infantil", "desarrollo neurológico", "desarrollo psicomotor", "desarrollo sensorial",
  "desarrollo cognitivo", "desarrollo social", "desarrollo emocional", "desarrollo afectivo",
  "habilidades motoras", "habilidades cognitivas", "habilidades sociales", "habilidades prelingüísticas",
  "habilidades comunicativas", "habilidades de juego", "habilidades de interacción", "habilidades adaptativas",
  "habilidades de alimentación", "habilidades de autonomía",

  // Motricidad
  "motricidad fina", "motricidad gruesa", "psicomotricidad", "coordinación ojo-mano",
  "coordinación motora", "equilibrio", "postura", "gateo", "caminar", "correr", "saltos",
  "destrezas motoras", "movimientos voluntarios", "movimientos reflejos",

  // Lenguaje y comunicación
  "lenguaje", "lenguaje verbal", "lenguaje no verbal", "comprensión verbal", "expresión verbal",
  "pronunciación", "vocabulario", "articulación", "comunicación temprana", "desarrollo del habla",
  "prelingüístico", "balbuceo", "habla funcional", "interacción comunicativa",

  // Cognición y sensorial
  "atención", "memoria", "percepción visual", "percepción auditiva", "percepción táctil",
  "percepción espacial", "procesamiento sensorial", "integración sensorial", "discriminación visual",
  "discriminación auditiva", "razonamiento", "resolución de problemas", "juego simbólico",
  "imaginación", "curiosidad", "exploración", "reconocimiento de objetos", "asociación de sonidos",

  // Siglas y abreviaturas comunes
  "bb", "bebe", "peque", "TO", "FA", "PT", "OT", "fono", "fonoaudiología", "TO pediátrico", "rehab pediátrica",
  "estimulación bb", "estimulación bebé", "desarrollo bb", "desarrollo bebé", "habilidades bb",

  // Otros términos generales
  "juego terapéutico", "rutinas diarias", "actividad lúdica", "actividad sensorial", "actividad cognitiva",
  "actividad motora", "apoyo al desarrollo", "intervención familiar", "cuidados tempranos", "desarrollo integral",
  "estimulación temprana en casa", "estimulación temprana infantil", "programa de desarrollo",
  "estimulación educativa", "estimulación emocional", "estimulación afectiva", "desarrollo psicopedagógico",
  "estimulación motora fina", "estimulación motora gruesa", "terapia de estimulación", "estimulación neurocognitiva"
];



    final lower = message.toLowerCase();
    return greetings.any((g) => lower == g) || farewells.any((f) => lower == f) || topics.any((t) => lower.contains(t));
  }

  Future<void> sendMessage() async {
    final message = promptController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      promptController.clear();
      prompt.add(ModelMessage(isPrompt: true, message: message, time: DateTime.now()));
      isLoading = true;
      prompt.add(ModelMessage(isPrompt: false, message: "🤖 NEOBOT está pensando...", time: DateTime.now()));
    });

    await Future.delayed(const Duration(milliseconds: 100));
    _scrollToBottom();

    if (!isRelevant(message)) {
      setState(() {
        prompt.removeLast();
        prompt.add(ModelMessage(
          isPrompt: false,
          message: "⚠️ Solo puedo ayudarte con estimulación sensorial, desarrollo infantil y rehabilitación pediátrica.",
          time: DateTime.now(),
        ));
        isLoading = false;
      });
      _saveMessages();
      _scrollToBottom();
      return;
    }

    try {
      final model = GenerativeModel(model: "gemini-2.0-flash", apiKey: apiKey);
      final content = [Content.text(message)];
      final response = await model.generateContent(content);

      setState(() {
        prompt.removeLast();
        prompt.add(ModelMessage(
          isPrompt: false,
          message: response.text ?? "⚠️ No se pudo obtener una respuesta.",
          time: DateTime.now(),
        ));
        isLoading = false;
      });
      _saveMessages();
      _scrollToBottom();
    } catch (e) {
      setState(() {
        prompt.removeLast();
        prompt.add(ModelMessage(
          isPrompt: false,
          message: "Ups,parece que no tienes conexion a internet asegurate de tener internet para que pueda ayudarte🥺",
          time: DateTime.now(),
        ));
        isLoading = false;
      });
      _saveMessages();
      _scrollToBottom();
    }
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prompt.map((e) => json.encode({
      'isPrompt': e.isPrompt,
      'message': e.message,
      'time': e.time.toIso8601String()
    })).toList();
    await prefs.setStringList('chat_history', data);
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('chat_history');
    if (data != null) {
      setState(() {
        prompt.clear();
        prompt.addAll(data.map((item) {
          final decoded = json.decode(item);
          return ModelMessage(
            isPrompt: decoded['isPrompt'],
            message: decoded['message'],
            time: DateTime.parse(decoded['time']),
          );
        }));
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxBubbleWidth = MediaQuery.of(context).size.width * 0.75;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 8,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFE0F7), Color(0xFFE0F7FA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          centerTitle: true,
          title: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "🤖 NEOBOT",
                    style: TextStyle(
                        color: Color(0xFF0288D1),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 2),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.9),
                    child: const Text(
                      "MIS RESPUESTAS SON SOLO SUGERENCIAS Y EN NINGÚN MOMENTO SUSTITUYO A UN MÉDICO PROFESIONAL",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF3E0), Color(0xFFE0F7FA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                children: const [
                  CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          AssetImage("assets/images/neobot_icon.png")),
                  SizedBox(width: 12),
                  Text("NEOBOT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF0288D1))),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(12),
                cacheExtent: 2000,
                itemCount: prompt.length,
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) {
                  final message = prompt[index];
                  return UserPrompt(
                    isPrompt: message.isPrompt,
                    message: message.message,
                    date: DateFormat('hh:mm a').format(message.time),
                    maxWidth: maxBubbleWidth,
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: TextField(
                  controller: promptController,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Escribe un mensaje...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    suffixIcon: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Color(0xFF0288D1)),
                          )
                        : IconButton(
                            icon: const Icon(Icons.send,
                                color: Color(0xFF0288D1)),
                            onPressed: isLoading ? null : sendMessage,
                          ),
                  ),
                  onSubmitted: (_) => sendMessage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserPrompt extends StatelessWidget {
  final bool isPrompt;
  final String message;
  final String date;
  final double maxWidth;

  const UserPrompt(
      {super.key,
      required this.isPrompt,
      required this.message,
      required this.date,
      required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isPrompt ? const Color(0xFFFFF9C4) : const Color(0xFFE0F7FA);

    if (isPrompt) {
      return Align(
        alignment: Alignment.centerRight,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(0),
          ),
          child: Container(
            color: bubbleColor,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SelectableText(message,
                    style: const TextStyle(fontSize: 15, height: 1.4)),
                const SizedBox(height: 4),
                Text(date,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
              ],
            ),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage("assets/images/neobot_icon.png"),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(20),
                ),
                child: Container(
                  color: bubbleColor,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(14),
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(message,
                          style: const TextStyle(fontSize: 15, height: 1.4)),
                      const SizedBox(height: 4),
                      Text(date,
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}