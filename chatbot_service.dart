import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotService {
  final _apiKey = 'AIzaSyCdl44cvjZ5A0SyTFXD3ks79txVDN65Tz0'; // Asegúrate de reemplazar esto con tu propia clave API.

  Future<String> getChatResponse(String prompt) async {
    final url = Uri.parse('https://generativeai.googleapis.com/v1beta2/models/text-bison-001:predict');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };

    final body = json.encode({
      "instances": [
        {"content": prompt}
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final reply = responseBody['predictions'][0]['content'];
        return reply;
      } else {
        throw Exception('Failed to fetch response');
      }
    } catch (e) {
      print("Error: $e");
      return 'Something went wrong. Please try again later.';
    }
  }
}


