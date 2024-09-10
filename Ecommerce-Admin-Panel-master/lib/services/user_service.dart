import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String apiUrl = 'https://your-api-url.com/api'; // Asegúrate de poner tu URL del backend

  // Método para obtener países desde el backend de Spring Boot
  Future<List<String>> getPaises() async {
    final response = await http.get(Uri.parse('$apiUrl/paises'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((pais) => pais['nombre'].toString()).toList();
    } else {
      throw Exception('Error al obtener los países');
    }
  }

  // Método para obtener ciudades basadas en el país desde el backend de Spring Boot
  Future<List<String>> getCiudades(String pais) async {
    final response = await http.get(Uri.parse('$apiUrl/ciudades/$pais'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((ciudad) => ciudad['nombre'].toString()).toList();
    } else {
      throw Exception('Error al obtener las ciudades');
    }
  }

  // Método para obtener roles desde el backend de Spring Boot
  Future<List<String>> getRoles() async {
    final response = await http.get(Uri.parse('$apiUrl/roles'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((rol) => rol['nombre'].toString()).toList();
    } else {
      throw Exception('Error al obtener los roles');
    }
  }

  // Método para crear un usuario en el backend de Spring Boot
  Future<void> crearUsuario(Map<String, String> usuarioData) async {
    final response = await http.post(
      Uri.parse('$apiUrl/usuarios'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(usuarioData),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al crear el usuario');
    }
  }

  // Método para editar un usuario en el backend de Spring Boot
  Future<void> editarUsuario(int id, Map<String, String> usuarioData) async {
    final response = await http.put(
      Uri.parse('$apiUrl/usuarios/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(usuarioData),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al editar el usuario');
    }
  }

  // Método para eliminar un usuario en el backend de Spring Boot
  Future<void> eliminarUsuario(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/usuarios/$id'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el usuario');
    }
  }
}