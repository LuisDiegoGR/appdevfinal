import 'package:appdevfinal/InicioApp.dart';
import 'package:flutter/material.dart';

class ConsultarEspecialista extends StatefulWidget {
  const ConsultarEspecialista({Key? key}) : super(key: key);

  @override
  _ConsultarEspecialistaState createState() => _ConsultarEspecialistaState();
}

class _ConsultarEspecialistaState extends State<ConsultarEspecialista> with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _showDoctorAvailability = true;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showDoctorAvailability = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.forward(from: 0.0); // Reinicia la animación desde el inicio
  }

  @override
  void dispose() {
    _textController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage(String message) {
    setState(() {
      _messages.insert(0, {'text': message, 'isUser': true});
    });
    _textController.clear();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.insert(0, {
            'text': 'Respuesta de la Doctora Maria Eugenia: $message',
            'isUser': false
          });
        });
      }
    });
  }

  Widget _buildMessage(Map<String, dynamic> message, bool isUser) {
    final bgColor = isUser ? Colors.blue[100] : Colors.blue;
    final textColor = isUser ? Colors.black : Colors.white;
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final icon = isUser ? Icons.person : Icons.person_outline;
    final borderRadius = isUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: borderRadius,
          ),
          child: Text(
            message['text'],
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isUser) Icon(icon, color: Colors.grey),
            const SizedBox(width: 8),
            CircleAvatar(
              child: Icon(icon),
              backgroundColor: Colors.grey[200],
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const InicioApp()),
      (Route<dynamic> route) => false,
    );
    return false; // Evita el comportamiento predeterminado del botón de retroceso
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFE8EAF6), Color(0xFF7986CB)],
                ),
              ),
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => const InicioApp()),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SlideTransition(
                    position: _offsetAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: AnimatedOpacity(
                        duration: const Duration(seconds: 2),
                        opacity: _showDoctorAvailability ? 1.0 : 0.0,
                        curve: Curves.easeInOut,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Especialista médico disponible de lunes a viernes de 14:00 a 15:00',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: _messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final message = _messages[index];
                        final isUser = message['isUser'];
                        return _buildMessage(message, isUser);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Consulta tus dudas',
                              labelStyle: const TextStyle(color: Colors.black),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.black),
                          onPressed: () {
                            if (_textController.text.isNotEmpty) {
                              _sendMessage(_textController.text);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: 250,
                height: 250,
                child: Image.asset(
                  'assets/images/ride.gif',
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ConsultarEspecialista(),
  ));
}
