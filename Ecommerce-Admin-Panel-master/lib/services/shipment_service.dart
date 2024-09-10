import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ShipmentService {
  final String apiUrl = 'http://your-backend-url/api/envios'; // Cambia por la URL de tu API

  Future<List<Map<String, dynamic>>> getEnvios() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => json as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load envíos');
    }
  }

  Future<void> deleteEnvio(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete envío');
    }
  }

  Future<void> createEnvio(Map<String, dynamic> envio) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(envio),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create envío');
    }
  }

  Future<void> updateEnvio(int id, Map<String, dynamic> envio) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(envio),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update envío');
    }
  }
}