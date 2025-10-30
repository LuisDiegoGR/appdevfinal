import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultarEspecialista extends StatefulWidget {
  @override
  _ConsultarEspecialistaState createState() => _ConsultarEspecialistaState();
}

class _ConsultarEspecialistaState extends State<ConsultarEspecialista> {
  List<Recuerdo> recuerdos = [];
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  Uint8List? imagenSeleccionada;
  final Random random = Random();
  bool _mostrarFormulario = false;
  String fondoImagen = 'assets/images/fondo_espacio_final2.jpg';

  @override
  void initState() {
    super.initState();
    _cargarRecuerdos();
  }

  Future<void> _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Uint8List bytes = await pickedFile.readAsBytes();
      setState(() {
        imagenSeleccionada = bytes;
      });
    }
  }

  void _guardarRecuerdo() {
    if (tituloController.text.isNotEmpty &&
        fechaController.text.isNotEmpty &&
        imagenSeleccionada != null) {
      setState(() {
        double x = random.nextDouble() * 300 + 50;
        double y = random.nextDouble() * 500 + 50;

        recuerdos.add(Recuerdo(
          titulo: tituloController.text,
          propuesta: fechaController.text,
          imagen: imagenSeleccionada,
          posicion: Offset(x, y),
        ));
        _guardarRecuerdosEnPreferencias();
        tituloController.clear();
        fechaController.clear();
        imagenSeleccionada = null;
      });
    }
  }

  void _guardarRecuerdosEnPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recuerdosJson = recuerdos.map((recuerdo) {
      return jsonEncode({
        'titulo': recuerdo.titulo,
        'propuesta': recuerdo.propuesta,
        'imagen': base64Encode(recuerdo.imagen!),
        'posicion': {'x': recuerdo.posicion.dx, 'y': recuerdo.posicion.dy},
      });
    }).toList();
    prefs.setStringList('recuerdos', recuerdosJson);
  }

  Future<void> _cargarRecuerdos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? recuerdosJson = prefs.getStringList('recuerdos');
    if (recuerdosJson != null) {
      setState(() {
        recuerdos = recuerdosJson.map((jsonStr) {
          final Map<String, dynamic> recuerdoMap = jsonDecode(jsonStr);
          return Recuerdo(
            titulo: recuerdoMap['titulo'],
            propuesta: recuerdoMap['propuesta'],
            imagen: base64Decode(recuerdoMap['imagen']),
            posicion: Offset(
              recuerdoMap['posicion']['x'],
              recuerdoMap['posicion']['y'],
            ),
          );
        }).toList();
      });
    }
  }

  void _editarRecuerdo(Recuerdo recuerdo) {
    setState(() {
      tituloController.text = recuerdo.titulo;
      fechaController.text = recuerdo.propuesta;
      imagenSeleccionada = recuerdo.imagen;
      _mostrarFormulario = true; // Abrir formulario
    });
    recuerdos.remove(recuerdo); // Lo quitamos para volver a guardarlo
  }

  void _eliminarRecuerdo(Recuerdo recuerdo) {
    setState(() {
      recuerdos.remove(recuerdo);
    });
    _guardarRecuerdosEnPreferencias();
    Navigator.of(context).pop();
  }

  Offset _limitarPosicion(Offset posicion, Size size) {
    double maxWidth = size.width - 60;
    double maxHeight = size.height - 60;
    return Offset(posicion.dx.clamp(0.0, maxWidth),
        posicion.dy.clamp(0.0, maxHeight));
  }

  void _mostrarDetalleRecuerdo(Recuerdo recuerdo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                recuerdo.titulo,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[700],
                ),
              ),
              SizedBox(height: 8),
              Text(
                recuerdo.propuesta ?? 'Sin fecha',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 15),
              recuerdo.imagen != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(recuerdo.imagen!,
                          height: 150, width: 150, fit: BoxFit.cover),
                    )
                  : Icon(Icons.image_not_supported,
                      size: 60, color: Colors.grey),
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                    label: Text("Cerrar"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[300],
                        foregroundColor: Colors.white),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _editarRecuerdo(recuerdo),
                    icon: Icon(Icons.edit),
                    label: Text("Editar"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[300],
                        foregroundColor: Colors.white),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _eliminarRecuerdo(recuerdo),
                    icon: Icon(Icons.delete),
                    label: Text("Eliminar"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[300],
                        foregroundColor: Colors.white),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🌟 Tu Bebé, su Estrella"),
        backgroundColor: Colors.purple[200],
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(fondoImagen, fit: BoxFit.cover),
          ),

          // 🌌 InteractiveViewer para zoom y desplazamiento
          Positioned.fill(
            child: InteractiveViewer(
              panEnabled: true,
              scaleEnabled: true,
              minScale: 0.5,
              maxScale: 3.0,
              boundaryMargin: EdgeInsets.all(200),
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: ConstellationPainter(recuerdos, _limitarPosicion),
                  ),
                  ...recuerdos.map((recuerdo) {
                    return Positioned(
                      left: recuerdo.posicion.dx,
                      top: recuerdo.posicion.dy,
                      child: GestureDetector(
                        onTap: () => _mostrarDetalleRecuerdo(recuerdo),
                        child: Column(
                          children: [
                            ClipOval(
                              child: recuerdo.imagen != null
                                  ? Image.memory(recuerdo.imagen!,
                                      height: 60, width: 60, fit: BoxFit.cover)
                                  : Container(
                                      height: 60,
                                      width: 60,
                                      color: Colors.pink[100],
                                      child: Icon(Icons.star,
                                          color: Colors.white, size: 30),
                                    ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              recuerdo.titulo,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // 🌸 Formulario flotante
          if (_mostrarFormulario)
            Positioned.fill(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(25),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink.shade50, Colors.purple.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 5))
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.redAccent),
                            onPressed: () {
                              setState(() {
                                _mostrarFormulario = false;
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.auto_awesome,
                                color: Colors.purple[400], size: 28),
                            SizedBox(width: 8),
                            Text("Nuevo Recuerdo",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple[700])),
                          ],
                        ),
                        SizedBox(height: 18),
                        TextField(
                          controller: tituloController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon:
                                Icon(Icons.title, color: Colors.purple[300]),
                            labelText: 'Título',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: fechaController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.calendar_today,
                                color: Colors.purple[300]),
                            labelText: 'Fecha',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            _DateFormatter(),
                          ],
                        ),
                        SizedBox(height: 12),
                        imagenSeleccionada != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(imagenSeleccionada!,
                                    height: 120, fit: BoxFit.cover),
                              )
                            : Text('🌸 No has seleccionado imagen',
                                style: TextStyle(color: Colors.grey[600])),
                        SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _seleccionarImagen,
                                icon: Icon(Icons.image),
                                label: Text("Imagen"),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  backgroundColor: Colors.pink[200],
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _guardarRecuerdo();
                                  setState(() {
                                    _mostrarFormulario = false;
                                  });
                                },
                                icon: Icon(Icons.save),
                                label: Text("Guardar"),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  backgroundColor: Colors.green[400],
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // 🌟 Botón flotante
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.purple[300],
              child: Icon(
                _mostrarFormulario ? Icons.edit_off : Icons.add,
                size: 28,
              ),
              onPressed: () {
                setState(() {
                  _mostrarFormulario = !_mostrarFormulario;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Recuerdo {
  final String titulo;
  final String propuesta;
  final Uint8List? imagen;
  final Offset posicion;

  Recuerdo({
    required this.titulo,
    required this.propuesta,
    required this.imagen,
    required this.posicion,
  });
}

class ConstellationPainter extends CustomPainter {
  final List<Recuerdo> recuerdos;
  final Offset Function(Offset, Size) limitarPosicion;
  ConstellationPainter(this.recuerdos, this.limitarPosicion);

  @override
  void paint(Canvas canvas, Size size) {
    final paintLinea = Paint()
      ..color = Colors.pinkAccent.withOpacity(0.6)
      ..strokeWidth = 2;

    final paintPunto = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    for (int i = 0; i < recuerdos.length - 1; i++) {
      Offset start = limitarPosicion(recuerdos[i].posicion, size);
      Offset end = limitarPosicion(recuerdos[i + 1].posicion, size);
      canvas.drawLine(start, end, paintLinea);
    }

    for (var recuerdo in recuerdos) {
      Offset posicion = limitarPosicion(recuerdo.posicion, size);
      canvas.drawCircle(posicion, 4, paintPunto);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 2 && text.length <= 4) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    } else if (text.length > 4) {
      text =
          '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4)}';
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
