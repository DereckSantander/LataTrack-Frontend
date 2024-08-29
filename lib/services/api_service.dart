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
      return data
          .map((item) => Transaction(
                id: item['id'],
                amount: item['amount'],
                description: item['description'],
                created: DateTime.parse(item['created']),
                categoryId: item['category'],
                report: item['report'],
              ))
          .toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<List<Transaction>> fetchTransactionsByType(String filtro) async {
    final response = await http.get(Uri.parse('$baseUrl/transacciones/?category_type=$filtro'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => Transaction(
                id: item['id'],
                amount: item['amount'],
                description: item['description'],
                created: DateTime.parse(item['created']),
                categoryId: item['category'],
                report: item['report'],
              ))
          .toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<List<Transaction>> fetchTransactionsByDateRange(DateTime startDate, DateTime endDate) async {
    String start = startDate.toIso8601String().split('T')[0];
    String end = endDate.toIso8601String().split('T')[0];

    final response = await http.get(
      Uri.parse('$baseUrl/transacciones/?created_after=$start&created_before=$end'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => Transaction(
                id: item['id'],
                amount: item['amount'],
                description: item['description'],
                created: DateTime.parse(item['created']),
                categoryId: item['category'],
                report: item['report'],
              ))
          .toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categorias'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => Category(
                id: item['id'],
                name: item['name'],
                type: item['type'],
                color: item['color'],
                icono: item['icono'],
                created: DateTime.parse(item['created']),
              ))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> createCategory(String name, String type, String color, String icono) async {
    final response = await http.post(
      Uri.parse('$baseUrl/categorias/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'type': type,
        'color': color,
        'icono': icono,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create category');
    }
  }

  Future<List<Category>> fetchCategoriesByType(String filtro) async {
    final response = await http.get(Uri.parse('$baseUrl/categorias/?category_type=$filtro'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => Category(
                id: item['id'],
                name: item['name'],
                type: item['type'],
                color: item['color'],
                icono: item['icono'],
                created: DateTime.parse(item['created']),
              ))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> createTransaction(double monto, String descripcion, int idCategoria, String fechaCreacion) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transacciones/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'amount': monto,
        'description': descripcion,
        'category': idCategoria,
        'created': fechaCreacion,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create transaction');
    }
  }
}
