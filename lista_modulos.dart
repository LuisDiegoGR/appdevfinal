import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_page.dart';

// Mapa de iconos permitidos
final Map<String, IconData> iconMap = {
  "home": Icons.home,
  "chat": Icons.chat,
  "settings": Icons.settings,
  "book": Icons.book,
  "school": Icons.school,
};

class ListaModulos extends StatelessWidget {
  final String searchQuery;
  ListaModulos({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('modulos')
          .orderBy('fecha', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        
        var modulos = snapshot.data!.docs.where((modulo) {
          return modulo['titulo']
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
        }).toList();

        return ListView.builder(
          itemCount: modulos.length,
          itemBuilder: (context, index) {
            var modulo = modulos[index];
            Color color = Color(modulo['color']);
            
            // Busca el icono, si no existe usa uno por defecto
            IconData icon = iconMap[modulo['icono']] ?? Icons.help;

            return Card(
              color: color,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(icon, color: Colors.white, size: 30),
                title: Text(modulo['titulo'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: Text(modulo['descripcion'],
                    style: TextStyle(color: Colors.white70)),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () => _eliminarModulo(context, modulo.id),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatPage(modulo.id, modulo['titulo']),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void _eliminarModulo(BuildContext context, String id) {
    FirebaseFirestore.instance.collection('modulos').doc(id).delete();
  }
}