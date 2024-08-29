import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../services/api_service.dart';
import '../../src/models.dart';
import 'package:latatrack/src/Categorias.dart';

class TransactionList extends StatelessWidget {
  final ApiService apiService;
  final bool type;
  final String filtro;

  const TransactionList({super.key, required this.apiService, required this.type, required this.filtro});

  Future<List<Map<String, dynamic>>> _fetchAndMapData() async {
    final transactions = type ? await apiService.fetchTransactionsByType(filtro) : await apiService.fetchTransactions();
    final categories = await apiService.fetchCategories();

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
        future: _fetchAndMapData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.black),
            ));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No transactions found.'));
          }

          final transactions = snapshot.data!;

          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Detalle de transaccion'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Categoría: ${transaction['categoryName']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Descripcion: ${transaction['description']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Monto: \$${transaction['amount']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 64,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87.withOpacity(0.5)),
                        color: const Color.fromARGB(188, 192, 213, 195),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color(int.parse(transaction['categoryColor'].replaceFirst('#', '0xff'))),
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(Categorias.fromString(transaction['categoryIcon'])),
                          ),
                          const SizedBox(
                            height: 8,
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              transaction['categoryName'],
                              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            transaction['categoryType'] == 'ingreso'
                                ? "\$" + transaction['amount']
                                : "-\$" + transaction['amount'],
                            style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
