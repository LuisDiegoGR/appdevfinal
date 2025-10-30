import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalisisPage extends StatefulWidget {
  @override
  _AnalisisPageState createState() => _AnalisisPageState();
}

class _AnalisisPageState extends State<AnalisisPage> {
  final TextEditingController _searchController = TextEditingController();

  Map<String, Map<String, int>> _resultadosPorColeccion = {};

  void _searchData() async {
    String searchQuery = _searchController.text.trim().toLowerCase();

    if (searchQuery.isNotEmpty) {
      Map<String, Map<String, int>> resultados = {};

      // Colecciones relevantes
      List<String> collections = [
        'evaluaciones',
        'evaluacioncuartomesV',
        'evaluacionquintomesV',
        'evaluacion6mesesamarillo'
      ];

      for (String collection in collections) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(collection)
            .where('resultado', isNotEqualTo: null)
            .get();

        int rojo = 0;
        int amarillo = 0;
        int verde = 0;

        for (var doc in querySnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;
          String resultado = data['resultado']?.toString().toLowerCase() ?? '';

          if (resultado.contains('rojo')) {
            rojo++;
          } else if (resultado.contains('amarillo')) {
            amarillo++;
          } else if (resultado.contains('verde')) {
            verde++;
          }
        }

        resultados[collection] = {
          'rojo': rojo,
          'amarillo': amarillo,
          'verde': verde,
        };
      }

      // Actualizar estado
      setState(() {
        _resultadosPorColeccion = resultados;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Análisis de Pacientes'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar datos',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchData,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _resultadosPorColeccion.keys.length,
                itemBuilder: (context, index) {
                  String collectionName =
                      _resultadosPorColeccion.keys.elementAt(index);
                  Map<String, int> resultados =
                      _resultadosPorColeccion[collectionName]!;

                  String tituloColeccion;
                  switch (collectionName) {
                    case 'evaluaciones':
                      tituloColeccion = 'RESULTADOS DEL MES TRES';
                      break;
                    case 'evaluacioncuartomesV':
                      tituloColeccion = 'RESULTADOS DEL MES CUATRO';
                      break;
                    case 'evaluacionquintomesV':
                      tituloColeccion = 'RESULTADOS DEL MES CINCO';
                      break;
                    case 'evaluacion6mesesamarillo':
                      tituloColeccion = 'RESULTADOS DEL MES SEIS';
                      break;
                    default:
                      tituloColeccion = 'RESULTADOS';
                  }

                  return Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tituloColeccion,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text('Bebés en Rojo: ${resultados['rojo']}',
                              style: TextStyle(fontSize: 16)),
                          Text('Bebés en Amarillo: ${resultados['amarillo']}',
                              style: TextStyle(fontSize: 16)),
                          Text('Bebés en Verde: ${resultados['verde']}',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateBarChart,
              child: Text('Generar Gráfica de Barras'),
            ),
          ],
        ),
      ),
    );
  }

  void _generateBarChart() {
    int totalRojo = 0;
    int totalAmarillo = 0;
    int totalVerde = 0;

    _resultadosPorColeccion.forEach((_, resultados) {
      totalRojo += resultados['rojo'] ?? 0;
      totalAmarillo += resultados['amarillo'] ?? 0;
      totalVerde += resultados['verde'] ?? 0;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Gráfica Generada'),
        content: AspectRatio(
          aspectRatio: 1.5,
          child: BarChart(
            BarChartData(
              barGroups: [
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: totalRojo.toDouble(),
                      color: Colors.red,
                      width: 20,
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                      toY: totalAmarillo.toDouble(),
                      color: Colors.yellow,
                      width: 20,
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                      toY: totalVerde.toDouble(),
                      color: Colors.green,
                      width: 20,
                    ),
                  ],
                ),
              ],
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 1:
                          return Text('Rojo');
                        case 2:
                          return Text('Amarillo');
                        case 3:
                          return Text('Verde');
                        default:
                          return Text('');
                      }
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) =>
                        Text(value.toInt().toString()),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}




