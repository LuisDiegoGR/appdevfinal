import 'package:flutter/material.dart';

class ConsultarEspecialista extends StatefulWidget {
  @override
  _ConsultarEspecialistaState createState() => _ConsultarEspecialistaState();
}

class _ConsultarEspecialistaState extends State<ConsultarEspecialista> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; // Inicializar como una lista de mapas
  bool _showDoctorAvailability = true;

  void _sendMessage(String message) {
    setState(() {
      _messages.insert(0, {'text': message, 'isUser': true}); // Mensaje del usuario
    });
    _textController.clear();

    // Simular respuesta del especialista
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.insert(0, {
          'text': 'Respuesta de la Doctora Maria Eugenia: $message',
          'isUser': false
        }); // Mensaje del especialista
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Ocultar el mensaje del médico después de 5 segundos
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _showDoctorAvailability = false;
      });
    });
  }

  Widget _buildMessage(Map<String, dynamic> message, bool isUser) {
    final bgColor = isUser ? Colors.blue[100] : Colors.blue;
    final textColor = isUser ? Colors.black : Colors.white;
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final icon = isUser ? Icons.person : Icons.person_outline;
    final borderRadius = isUser
        ? BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
            SizedBox(width: 8),
            CircleAvatar(
              child: Icon(icon),
              backgroundColor: Colors.grey[200],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: _showDoctorAvailability ? 1.0 : 0.0,
            curve: Curves.easeInOut,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
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
          Expanded(
            child: ListView.builder(
              reverse: true, // Para que los mensajes más recientes aparezcan arriba
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
                    decoration: InputDecoration(
                      labelText: 'Consulta tus dudas',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ConsultarEspecialista(),
  ));
}
