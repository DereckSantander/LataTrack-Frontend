import 'package:http/http.dart' as http;
import 'dart:convert';
import '../src/models.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<Transaction>> fetchTransactions() async {
    final response = await http.get(Uri.parse('$baseUrl/transacciones'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Transaction(
        id: item['id'],
        amount: item['amount'],
        description: item['description'],
        created: DateTime.parse(item['created']),
        categoryId: item['category'],
        report: item['report'],
      )).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<List<Transaction>> fetchTransactionsByType(String filtro) async {
    final response = await http.get(Uri.parse('$baseUrl/transacciones/?category_type=$filtro'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Transaction(
        id: item['id'],
        amount: item['amount'],
        description: item['description'],
        created: DateTime.parse(item['created']),
        categoryId: item['category'],
        report: item['report'],
      )).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categorias'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Category(
        id: item['id'],
        name: item['name'],
        type: item['type'],
        color: item['color'],
        icono: item['icono'],
        created: DateTime.parse(item['created']),
      )).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}