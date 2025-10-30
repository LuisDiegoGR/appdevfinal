import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Mes1Page.dart';
import 'Mes1_Page.dart';
import 'Mes2Page.dart';
import 'Mes2_Page.dart';
import 'Mes3Page.dart';
import 'confirmacion.dart';
import 'actividades_verde.dart';
import 'actividades_amarillo.dart';

class ActividadesPage extends StatefulWidget {
  @override
  _ActividadesPageState createState() => _ActividadesPageState();
}

class _ActividadesPageState extends State<ActividadesPage> {
  bool _verdeEnabled = false;
  bool _amarilloEnabled = false;
  bool _confirmacionDesbloqueada = false;
  bool _edadBloqueada = false; // ✅ NUEVA VARIABLE
  int? edadSemanas;
  DateTime? fechaGuardada;
  final TextEditingController _edadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEdad();
    _checkEvaluacionCompletada();
  }

  Future<void> _checkEvaluacionCompletada() async {
    final prefs = await SharedPreferences.getInstance();
    final completada = prefs.getBool('evaluacion_3meses_completada') ?? false;
    setState(() {
      _confirmacionDesbloqueada = completada;
    });
  }

  Future<void> _loadEdad() async {
    final prefs = await SharedPreferences.getInstance();
    final edad = prefs.getInt("edadSemanas");
    final fechaStr = prefs.getString("fechaGuardada");

    if (edad != null) {
      setState(() {
        edadSemanas = edad;
        _edadController.text = edad.toString();
        _edadBloqueada = true; // ✅ BLOQUEAR CAMBIO SI YA EXISTE
        if (fechaStr != null) {
          fechaGuardada = DateTime.parse(fechaStr);
        } else {
          fechaGuardada = DateTime.now();
          prefs.setString("fechaGuardada", fechaGuardada!.toIso8601String());
        }
      });
    }
  }

  Future<void> _saveEdad(int edad) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("edadSemanas", edad);
    fechaGuardada = DateTime.now();
    await prefs.setString("fechaGuardada", fechaGuardada!.toIso8601String());
  }

  void _validarEdad() {
    if (edadSemanas == null || edadSemanas! < 1 || edadSemanas! > 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ingresa una edad válida entre 1 y 12 semanas."),
          backgroundColor: Colors.pinkAccent,
        ),
      );
      return;
    }

    _saveEdad(edadSemanas!);
    setState(() {
      _edadBloqueada = true; // ✅ BLOQUEAR DESPUÉS DE GUARDAR
    });
  }

  void _openConfirmacion(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfirmacionPage()),
    );
    if (result != null) {
      setState(() {
        if (result['result'] == 'excelente') {
          _verdeEnabled = true;
          _amarilloEnabled = false;
        } else if (result['result'] == 'atencion') {
          _amarilloEnabled = true;
          _verdeEnabled = false;
        }
      });
    }
  }

  bool isUnlocked(int modulo) {
    if (edadSemanas == null || fechaGuardada == null) return false;
    final diasTranscurridos = DateTime.now().difference(fechaGuardada!).inDays;

    if (edadSemanas! >= 1 && edadSemanas! <= 4) {
      if (modulo == 1) return true;
      if (modulo == 2 && diasTranscurridos >= 31) return true;
      if (modulo == 3 && diasTranscurridos >= 60) return true;
    } else if (edadSemanas! >= 5 && edadSemanas! <= 8) {
      if (modulo == 1 || modulo == 2) return true;
      if (modulo == 3 && diasTranscurridos >= 31) return true;
    } else if (edadSemanas! >= 9 && edadSemanas! <= 12) {
      return true;
    }
    return false;
  }

  Widget getModuloPage(int modulo) {
    if (modulo == 1) {
      if (edadSemanas! >= 5) return Mes1_Page();
      return Mes1Page();
    }
    if (modulo == 2) {
      if (edadSemanas! >= 9) return Mes2_Page();
      if (edadSemanas! >= 5) return Mes2Page();
      return Mes2Page();
    }
    if (modulo == 3) return Mes3Page();
    return Mes1Page();
  }

  Widget _buildModuleCard(
    String title,
    String description,
    Color color1,
    Color color2,
    int numeroModulo,
    IconData icon,
  ) {
    bool activo = isUnlocked(numeroModulo);
    return GestureDetector(
      onTap: activo
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => getModuloPage(numeroModulo)),
              ).then((_) => _checkEvaluacionCompletada());
            }
          : null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: activo
              ? LinearGradient(
                  colors: [color1, color2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Colors.grey[300]!, Colors.grey[200]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: activo
              ? [
                  BoxShadow(
                    color: color1.withOpacity(0.4),
                    blurRadius: 15,
                    offset: Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: Icon(icon, color: activo ? color1 : Colors.grey, size: 32),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: activo ? Colors.white : Colors.black45,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          activo ? Colors.white.withOpacity(0.95) : Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
            if (activo)
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback? onPressed, List<Color> colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Ink(
          decoration: BoxDecoration(
            gradient: onPressed != null
                ? LinearGradient(
                    colors: colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [Colors.grey[400]!, Colors.grey[300]!],
                  ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: onPressed != null
                ? [
                    BoxShadow(
                      color: colors.last.withOpacity(0.5),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF6EC),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.favorite, color: Colors.pinkAccent),
            SizedBox(width: 8),
            Text("Actividades del Bebé"),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 6,
        shadowColor: Colors.deepPurpleAccent.withOpacity(0.4),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edad del bebé (1-12 semanas):",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _edadController,
                    enabled: !_edadBloqueada, // ✅ DESHABILITAR SI YA ESTÁ GUARDADA
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Ingresa edad en semanas",
                      prefixIcon: Icon(Icons.cake, color: Colors.purpleAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                    onChanged: (value) {
                      setState(() {
                        edadSemanas = int.tryParse(value);
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _edadBloqueada ? null : _validarEdad, // ✅ DESHABILITAR BOTÓN
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                  child: const Text("Aceptar"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildModuleCard(
              'Actividades Mes 1',
              'Explora juegos y estimulación para el primer mes.',
              Colors.pinkAccent,
              Colors.pink.shade200,
              1,
              Icons.baby_changing_station,
            ),
            _buildModuleCard(
              'Actividades Mes 2',
              'Ejercicios y actividades para el segundo mes.',
              Colors.lightGreen,
              Colors.greenAccent,
              2,
              Icons.self_improvement,
            ),
            _buildModuleCard(
              'Actividades Mes 3',
              'Desarrollo y estimulación para el tercer mes.',
              Colors.lightBlue,
              Colors.cyanAccent,
              3,
              Icons.child_care,
            ),
            const Divider(height: 40, thickness: 2, color: Colors.grey),
            Center(
              child: Text(
                "Resultados de Evaluación",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildButton(
              'Ir a Confirmación 📝',
              _confirmacionDesbloqueada
                  ? () => _openConfirmacion(context)
                  : null,
              [Colors.purpleAccent, Colors.deepPurpleAccent],
            ),
            _buildButton(
              'Resultado Verde ✅',
              _verdeEnabled
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActividadesVerdePage()),
                      );
                    }
                  : null,
              [Colors.green, Colors.lightGreen],
            ),
            _buildButton(
              'Resultado Amarillo ⚠',
              _amarilloEnabled
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActividadesAmarilloPage()),
                      );
                    }
                  : null,
              [Colors.orangeAccent, Colors.deepOrangeAccent],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ActividadesPage(),
  ));
}