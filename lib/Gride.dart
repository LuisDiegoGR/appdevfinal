import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Overlapped extends StatefulWidget {
  const Overlapped({Key? key}) : super(key: key);

  @override
  State<Overlapped> createState() => _OverlappedState();
}

class _OverlappedState extends State<Overlapped> {
  final List<String> imagePaths = [
    'assets/ImagesOver/0.jpg',
    'assets/ImagesOver/1.jpg',
    'assets/ImagesOver/2.jpg',
    'assets/ImagesOver/3.jpg',
  ];

  List<Widget> _buildImageWidgets() {
    return imagePaths.map((path) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          child: Image.asset(
            path,
            fit: BoxFit.cover,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: min(screenWidth / 2.9 * (17 / 9), screenHeight * .9),
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.4, // Ajusta esta fracción para mostrar parcialmente las imágenes adyacentes
          ),
          items: _buildImageWidgets(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Overlapped(),
  ));
}
