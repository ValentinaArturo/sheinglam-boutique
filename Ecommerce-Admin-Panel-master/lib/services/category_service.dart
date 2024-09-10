import 'dart:convert';
import 'package:ecommerce_admin_panel/model/category.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  final String baseUrl = 'http://tu-backend.com/api/Categorys';

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Categorys');
    }
  }

  Future<void> addCategory(Category Category) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(Category.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add Category');
    }
  }

  Future<void> updateCategory(int id, Category Category) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(Category.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update Category');
    }
  }

  Future<void> deleteCategory(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete Category');
    }
  }

}