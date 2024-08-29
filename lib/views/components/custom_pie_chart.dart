import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../services/api_service.dart';
import '../../src/models.dart';

class CustomPieChart extends StatelessWidget {
  final ApiService apiService;

  const CustomPieChart({
    super.key,
    required this.apiService,
  });

  static var totalIngresos = 0.0;
  static var totalEgresos = 0.0;

  double sumarMontos(List arreglo) {
    double totalMonto = 0.0;
    for (var elemento in arreglo) {
      totalMonto += int.parse(elemento['monto']);
    }
    return totalMonto;
  }

  Future<List<Map<String, dynamic>>> _fetch() async {
    final transactionsI = await apiService.fetchTransactionsByType("ingreso");
    final transactionsE = await apiService.fetchTransactionsByType("gasto");
    final transactions = await apiService.fetchTransactions();
    final categories = await apiService.fetchCategories();

    totalIngresos = transactionsI
        .map((transaction) => double.tryParse(transaction.amount) ?? 0.0)
        .fold(0.0, (sum, amount) => sum + amount);

    totalEgresos = transactionsE
        .map((transaction) => double.tryParse(transaction.amount) ?? 0.0)
        .fold(0.0, (sum, amount) => sum + amount);

    return transactions.map((transaction) {
      final category = categories.firstWhere(
        (cat) => cat.id == transaction.categoryId,
        orElse: () => Category(
            id: -1, name: 'Unknown', type: 'Unknown', color: '#FFFFFF', icono: 'unknown', created: DateTime.now()),
      );

      return {
        'amount': transaction.amount,
        'description': transaction.description,
        'created': transaction.created,
        'categoryName': category.name,
        'categoryType': category.type,
        'categoryColor': category.color,
        'categoryIcon': category.icono,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No transactions found.'));
          }

          final transactions = snapshot.data!;

          return AspectRatio(
            aspectRatio: 1.2,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: PieChart(
                PieChartData(sections: [
                  PieChartSectionData(
                    value: totalIngresos,
                    color: const Color.fromARGB(255, 56, 136, 62),
                    radius: 60,
                    titleStyle: const TextStyle(fontSize: 15),
                    borderSide: const BorderSide(width: 2),
                    titlePositionPercentageOffset: 0.4,
                    badgePositionPercentageOffset: 1,
                  ),
                  PieChartSectionData(
                      value: totalEgresos,
                      color: const Color.fromARGB(255, 185, 87, 11),
                      radius: 55,
                      titleStyle: const TextStyle(fontSize: 15),
                      borderSide: const BorderSide(width: 2),
                      titlePositionPercentageOffset: 0.4,
                      badgePositionPercentageOffset: 1),
                ]),
              ),
            ),
          );
        });
  }
}
