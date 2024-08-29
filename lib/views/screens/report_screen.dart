import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latatrack/globals.dart';
import 'package:latatrack/services/api_service.dart';
import 'package:latatrack/src/models.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  ApiService apiservice = ApiService(ipApi);

  List<Transaction>? transaccionesFiltradas;

  Future<List<Map<String, dynamic>>> _fetchAndMapData(DateTime start, DateTime end) async {
    final transactions = await apiservice.fetchTransactionsByDateRange(start, end);
    final categories = await apiservice.fetchCategories();

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

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startController.text = 'Start Date: ${DateFormat('yyyy-MM-dd').format(_startDate!)}';
        } else {
          _endDate = picked;
          _endController.text = 'End Date: ${DateFormat('yyyy-MM-dd').format(_endDate!)}';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título del Reporte'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _startController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                ),
                onTap: () => _selectDate(context, true),
                validator: (value) {
                  if (_startDate == null) {
                    return 'Por favor, seleccionar start date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _endController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'End Date',
                ),
                onTap: () => _selectDate(context, false),
                validator: (value) {
                  if (_endDate == null) {
                    return 'Por favor, selecccionar end date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final transaccionesFiltradas = await _fetchAndMapData(_startDate!, _endDate!);

                    List<Map<String, dynamic>> ingresos =
                        transaccionesFiltradas.where((t) => t['categoryType'] == 'ingreso').toList();
                    List<Map<String, dynamic>> egresos =
                        transaccionesFiltradas.where((t) => t['categoryType'] == 'gasto').toList();
                    showReportDialog(context, _titleController.text, ingresos, egresos);
                  }
                },
                child: const Text('Generar reporte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showReportDialog(BuildContext context, String tituloReporte, List<Map<String, dynamic>> ingresos,
    List<Map<String, dynamic>> egresos) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        contentPadding: EdgeInsets.all(16.0),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tituloReporte,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Ingresos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ...ingresos.map((transaction) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(transaction['description']),
                        Text('\$${transaction['amount']}'),
                      ],
                    ),
                  )),
              SizedBox(height: 16),
              Text(
                'Egresos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ...egresos.map((transaction) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(transaction['description']),
                        Text('\$${transaction['amount']}'),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
    },
  );
}
