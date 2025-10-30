import 'package:flutter/material.dart';

// MES 1
import 'actividad_vistames1.dart';
import 'actividad_olfatomes1.dart';
import 'actividad_motrizmes1.dart';
import 'actividad_Desarrollo_vestibularmes1.dart';
import 'actividad_Neorologicames1.dart';
import 'actividad_audicionmes1.dart';

// MES 2
import 'actividad_vistames2.dart';
import 'actividad_tactomes2.dart';
import 'actividad_audicionmes2.dart';
import 'actividad_neurologicomes2.dart';
import 'actividad_olfatomes2.dart';
import 'actividad_Desarrollo_motrizmes2.dart'; 

// MES 3
import 'actividad_agarremes3.dart';
import 'actividad_cuellomes3.dart';
import 'actividad_Desarrollomotrizmes3.dart';
import 'actividad_neurologicomes3.dart';
import 'actividad_audicionmes3.dart';
import 'actividad_vista_tactomes3.dart';


// MES 4
import 'actividad_olfatomes4.dart';
import 'actividad_vistames4.dart';
import 'actividad_coordinacion_equilibriomes4.dart';
import 'actividadMes4_DesarrolloMotriz-Neurologicomes4.dart';
import 'actividad_DesarrolloVestíbular_Propioseptivomes4.dart';

// MES 5
import 'actividad_Coordinacion_Equilibrio_mes5.dart';
import 'actividad_Motrizmes5.dart';
import 'actividad_vistames5.dart';
import 'actividad_neurologicomes5.dart';
import 'actividad_audicionmes5.dart';
import 'actividad_olfatomes5.dart'; //CHECAR

// MES 6
import 'actividad_motrizmes6.dart';
import 'actividad_neurologicomes6.dart';
import 'actividad_olfato_gusto.dart';
import 'actividad_coordinacion_equilibriomes6.dart';
import 'actividad_vistames6.dart';
import 'actividad_audicionmes6.dart';

class ActividadTotalPage extends StatelessWidget {
  const ActividadTotalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividad Total por Mes'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Selecciona una actividad por mes:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          buildMes(context, 'Mes 1', [
            EstimVistaMes1(),
            ActividadOlfatoMes1(),
            ActividadMotrizMes1(),
            JuegoPage(),
            Video3Page(),
            ActividadAudicionMes1(),
          ]),
          buildMes(context, 'Mes 2', [
            ActividadVistaMes2(),
      ActividadTactoMes2(),
      ActividadAudicionMes2Page(),
      ActividadNeurologicoMes2(),
      ActividadOlfatoMes2(),
      ActividadDesarrolloMotrizMes2(),
          ]),
          buildMes(context, 'Mes 3', [
            ActividadAgarreMes3(),
      ActividadCuelloMes3(),
      ActividadDesarrollomotrizMes3(),
      ActividadNeurologicoMes3(),
      ActividadAudicionMes3(),
      ActividadVistaTactoMes3(),
          ]),
          buildMes(context, 'Mes 4', [
           ActividadVistaMes4(),
    ActividadCoordinacionEquilibrio(),
     ActividadDesarrolloVestibularPropioseptivoMes4(),
    ActividadMes4DesarrolloMotrizNeurologico(),
    ActividadOlfatoMes4(),
          ]),
          buildMes(context, 'Mes 5', [
            ActividadCoordinacionEquilibrioMes5(),
            ActividadMotrizMes5(),
            ActividadVistaMes5(),
            ActividadNeurologicoMes5(),
            ActividadAudicionMes5(),
            ActividadOlfatoMes5(),
          ]),
          buildMes(context, 'Mes 6', [
            ActividadMotrizMes6(),
            ActividadNeurologicoMes6(),
            ActividadOlfatoGusto(),
            ActividadCoordinacionEquilibrioMes6(),
            ActividadVistaMes6(),
            CuentoAudioPage(),
          ]),
        ],
      ),
    );
  }

  Widget buildMes(BuildContext context, String titulo, List<Widget> actividades) {
    return ExpansionTile(
      title: Text(titulo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      children: actividades.map((actividad) {
        String nombre = actividad.runtimeType.toString();
        return ListTile(
          title: Text(nombre.replaceAll("Actividad", "")),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => actividad),
            );
          },
        );
      }).toList(),
    );
  }
}

