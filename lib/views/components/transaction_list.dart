import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../services/api_service.dart';
import '../../src/models.dart';

class TransactionList extends StatelessWidget {
  final ApiService apiService;

  const TransactionList({super.key, required this.apiService});

  Future<List<Map<String, dynamic>>> _fetchAndMapData() async {
    final transactions = await apiService.fetchTransactions();
    final categories = await apiService.fetchCategories();

    return transactions.map((transaction) {
      final category = categories.firstWhere(
        (cat) => cat.id == transaction.categoryId,
        orElse: () => Category(
            id: -1,
            name: 'Unknown',
            type: 'Unknown',
            color: '#FFFFFF',
            icono: 'unknown',
            created: DateTime.now()),
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

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.black87.withOpacity(0.5)),
                      color: const Color.fromARGB(188, 192, 213, 195),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15)),
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
                              color: Color(int.parse(
                                  transaction['categoryColor']
                                      .replaceFirst('#', '0xff'))),
                              borderRadius: BorderRadius.circular(10)),
                          child: SvgPicture.asset(
                              'assets/icon/${transaction['categoryIcon']}.svg'),
                        ),
                        const SizedBox(
                          height: 8,
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            transaction['categoryName'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "\$" + transaction['amount'],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
