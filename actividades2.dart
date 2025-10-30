import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mes1_riesgo.dart';
import 'mes2_riesgo.dart';
import 'mes3_riesgo.dart';
import 'Mes1_Page.dart';
import 'Mes2_Page.dart';
import 'confirmacion.dart';
import 'actividades_verde.dart';
import 'actividades_amarillo.dart';

class Actividades2Page extends StatefulWidget {
  const Actividades2Page({super.key});

  @override
  State<Actividades2Page> createState() => _Actividades2PageState();
}

class _Actividades2PageState extends State<Actividades2Page> {
  final TextEditingController _controller = TextEditingController();
  int? semanas;

  bool resultadoVerdeDesbloqueado = false;
  bool resultadoAmarilloDesbloqueado = false;
  bool evaluacionCompletada = false;
  bool semanasBloqueadas = false;

  @override
  void initState() {
    super.initState();
    _cargarSemanasGuardadas();
    _verificarEvaluacionCompletada();
  }

  Future<void> _verificarEvaluacionCompletada() async {
    final prefs = await SharedPreferences.getInstance();
    final completada = prefs.getBool('evaluacion_3meses_completada') ?? false;
    setState(() {
      evaluacionCompletada = completada;
    });
  }

  Future<void> _cargarSemanasGuardadas() async {
    final prefs = await SharedPreferences.getInstance();
    final semanasGuardadas = prefs.getInt('edad_bebe_semanas');
    if (semanasGuardadas != null) {
      setState(() {
        semanas = semanasGuardadas;
        _controller.text = semanasGuardadas.toString();
        semanasBloqueadas = true;
      });
    }
  }

  Future<void> _guardarSemanas(int valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('edad_bebe_semanas', valor);
    setState(() {
      semanasBloqueadas = true;
    });
  }

  void _confirmarEdad() async {
    final int? semanasIngresadas = int.tryParse(_controller.text);
    if (semanasIngresadas == null || semanasIngresadas < 1 || semanasIngresadas > 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor ingresa una edad válida entre 1 y 12 semanas."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    await _guardarSemanas(semanasIngresadas);
    setState(() {
      semanas = semanasIngresadas;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Edad confirmada correctamente."),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool desbloquearMes1 = false;
    bool desbloquearMes2 = false;
    bool desbloquearMes3 = false;

    Widget destinoMes1 = Mes1Riesgo();
    Widget destinoMes2 = Mes2Riesgo();
    Widget destinoMes3 = Mes3Riesgo();

    if (semanas != null) {
      if (semanas! >= 1 && semanas! <= 4) {
        desbloquearMes1 = true;
        destinoMes1 = Mes1Riesgo();
      } else if (semanas! >= 5 && semanas! <= 8) {
        desbloquearMes1 = true;
        desbloquearMes2 = true;
        destinoMes1 = const Mes1_Page();
        destinoMes2 = Mes2Riesgo();
      } else if (semanas! >= 9 && semanas! <= 12) {
        desbloquearMes1 = true;
        desbloquearMes2 = true;
        desbloquearMes3 = true;
        destinoMes1 = const Mes1_Page();
        destinoMes2 = Mes2_Page();
        destinoMes3 = Mes3Riesgo();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividades con Riesgo'),
        backgroundColor: const Color(0xFFB39DDB),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8EAF6), Color(0xFFEDE7F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Indica la edad de tu bebé en semanas:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7E57C2),
                ),
              ),
              const SizedBox(height: 16),

              // Campo y botón en la misma fila
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      enabled: !semanasBloqueadas,
                      decoration: InputDecoration(
                        hintText: 'Ej. 6',
                        filled: true,
                        fillColor: semanasBloqueadas
                            ? Colors.grey.shade200
                            : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: semanasBloqueadas ? null : _confirmarEdad,
                    icon: const Icon(Icons.check_circle_outline, size: 20),
                    label: const Text("Aceptar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7E57C2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              if (semanas != null && semanas! >= 1 && semanas! <= 12) ...[
                const Text(
                  "Selecciona una opción:",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A1B9A),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                _buildMesCard(
                  context,
                  desbloquearMes1,
                  Icons.looks_one,
                  'Actividades Mes 1',
                  'Ver actividades del primer mes',
                  destinoMes1,
                  const Color(0xFFFFF3E0),
                ),
                const SizedBox(height: 20),

                _buildMesCard(
                  context,
                  desbloquearMes2,
                  Icons.looks_two,
                  'Actividades Mes 2',
                  'Ver actividades del segundo mes',
                  destinoMes2,
                  const Color(0xFFE1F5FE),
                ),
                const SizedBox(height: 20),

                _buildMesCard(
                  context,
                  desbloquearMes3,
                  Icons.looks_3,
                  'Actividades Mes 3',
                  'Ver actividades del tercer mes',
                  destinoMes3,
                  const Color(0xFFE8F5E9),
                ),
                const SizedBox(height: 40),

                const Divider(thickness: 2, color: Color(0xFFCE93D8)),
                const SizedBox(height: 20),

                _buildConfirmacionCard(context),
                const SizedBox(height: 20),

                _buildResultadoCard(
                  context,
                  resultadoVerdeDesbloqueado,
                  Icons.verified,
                  'Resultado Verde',
                  'Actividades para resultado verde',
                  ActividadesVerdePage(),
                  const Color(0xFFE0F2F1),
                ),
                const SizedBox(height: 20),

                _buildResultadoCard(
                  context,
                  resultadoAmarilloDesbloqueado,
                  Icons.warning,
                  'Resultado Amarillo',
                  'Actividades para resultado amarillo',
                  const ActividadesAmarilloPage(),
                  const Color(0xFFFFF9C4),
                ),
              ] else if (semanas != null &&
                  (semanas! < 1 || semanas! > 12)) ...[
                const SizedBox(height: 20),
                const Text(
                  "Por favor ingresa una edad entre 1 y 12 semanas.",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmacionCard(BuildContext context) {
    return Opacity(
      opacity: evaluacionCompletada ? 1.0 : 0.5,
      child: AbsorbPointer(
        absorbing: !evaluacionCompletada,
        child: Card(
          color: const Color(0xFFFFEBEE),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ConfirmacionPage()),
              );
              if (result != null && result is Map<String, dynamic>) {
                setState(() {
                  if (result['result'] == 'excelente') {
                    resultadoVerdeDesbloqueado = true;
                    resultadoAmarilloDesbloqueado = false;
                  } else if (result['result'] == 'atencion') {
                    resultadoAmarilloDesbloqueado = true;
                    resultadoVerdeDesbloqueado = false;
                  }
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.check_circle,
                        size: 28, color: Color(0xFF6A1B9A)),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirmar Resultado',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6A1B9A),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Verifica el resultado del bebé',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: 18, color: Color(0xFF6A1B9A)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMesCard(BuildContext context, bool desbloqueado, IconData icon,
      String titulo, String subtitulo, Widget destino, Color color) {
    return Opacity(
      opacity: desbloqueado ? 1.0 : 0.5,
      child: AbsorbPointer(
        absorbing: !desbloqueado,
        child: Card(
          color: color,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => destino));
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(icon, color: Colors.deepPurple, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(subtitulo,
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultadoCard(BuildContext context, bool desbloqueado,
      IconData icon, String titulo, String subtitulo, Widget destino, Color color) {
    return Opacity(
      opacity: desbloqueado ? 1.0 : 0.5,
      child: AbsorbPointer(
        absorbing: !desbloqueado,
        child: Card(
          color: color,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => destino)),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child:
                        Icon(icon, color: Colors.deepPurple, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(subtitulo,
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

