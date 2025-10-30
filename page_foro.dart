import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'chats.dart'; // Página de chats privados
import 'lista_modulos.dart'; // Archivo separado con la lista de módulos

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.purple,
      scaffoldBackgroundColor: Colors.grey[200],
    ),
    home: PageForo(),
  ));
}

class PageForo extends StatefulWidget {
  @override
  _PageForoState createState() => _PageForoState();
}

class _PageForoState extends State<PageForo> {
  String searchQuery = "";
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Foro de Discusión')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Buscar Módulo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchQuery = "";
                            searchController.clear();
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _mostrarFormulario(context),
                  child: Text('Añadir Módulo', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatsPage()),
                    );
                  },
                  child: Text('Chats Privados', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          Expanded(child: ListaModulos(searchQuery: searchQuery)),
        ],
      ),
    );
  }

  void _mostrarFormulario(BuildContext context) {
    String titulo = '';
    String descripcion = '';
    Color selectedColor = Colors.blue;
    IconData selectedIcon = Icons.chat;
    List<Color> colors = [Colors.blue, Colors.red, Colors.green, Colors.orange, Colors.purple];
    List<IconData> icons = [Icons.chat, Icons.book, Icons.school, Icons.computer, Icons.favorite];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text('Nuevo Módulo', textAlign: TextAlign.center),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Título', border: OutlineInputBorder()),
                    onChanged: (value) => titulo = value,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(labelText: 'Descripción', border: OutlineInputBorder()),
                    onChanged: (value) => descripcion = value,
                  ),
                  SizedBox(height: 10),
                  Text("Selecciona un color"),
                  Wrap(
                    children: colors.map((color) {
                      return GestureDetector(
                        onTap: () => setState(() => selectedColor = color),
                        child: Container(
                          margin: EdgeInsets.all(5),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(color: selectedColor == color ? Colors.black : Colors.transparent, width: 2),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Text("Selecciona un ícono"),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: Icon(selectedIcon, key: ValueKey<IconData>(selectedIcon), size: 40, color: Colors.purple),
                  ),
                  Wrap(
                    children: icons.map((icon) {
                      return IconButton(
                        icon: Icon(icon, color: selectedIcon == icon ? Colors.black : Colors.grey),
                        onPressed: () => setState(() => selectedIcon = icon),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white),
                  onPressed: () async {
                    if (titulo.isNotEmpty && descripcion.isNotEmpty) {
                      await FirebaseFirestore.instance.collection('modulos').add({
                        'titulo': titulo,
                        'descripcion': descripcion,
                        'color': selectedColor.value,
                        'icono': selectedIcon.codePoint,
                        'fecha': DateTime.now(),
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}






