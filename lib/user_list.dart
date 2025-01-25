import 'package:appdevfinal/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:appdevfinal/InicioApp.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  Future<ImageProvider> _getUserimageProvider(String uid) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('SubirImage/$uid.jpg');
      final imageUrl = await ref.getDownloadURL();
      return NetworkImage(imageUrl);
    } catch (e) {
      return const AssetImage('assets/images/Placeholder.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentUserId = currentUser?.uid;

    if (currentUserId == null) {
      return const Center(child: Text("No se ha autenticado ningún usuario."));
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const InicioApp()));
          },
        ),
        title: const Text('Lista de Usuarios'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay usuarios disponibles'));
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final name = user['name'];
              final uid = user.id;

              return FutureBuilder<ImageProvider>(
                future: _getUserimageProvider(uid),
                builder: (context, imageSnapshot) {
                  if (imageSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const ListTile(
                      leading: CircularProgressIndicator(),
                      title: Text('Cargando...'),
                    );
                  }

                  final imageProvider = imageSnapshot.data ??
                      const AssetImage('assets/images/Placeholder.jpg');

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: imageProvider,
                    ),
                    title: Text(name),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                    currentUserId: currentUserId,
                                    recipientId: uid,
                                    recipientName: name,
                                    recipientImageProvider: imageProvider,
                                  )));
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
