import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latatrack/views/screens/report_screen.dart';
import '../../services/api_service.dart';
import '../components/segment_button.dart';
import '../components/transaction_list.dart';
import 'package:latatrack/globals.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final ApiService apiService = ApiService(ipApi);
  bool isIngresos = true;

  double sumarMontos(List arreglo) {
    double totalMonto = 0.0;
    for (var elemento in arreglo) {
      totalMonto += int.parse(elemento['monto']);
    }
    return totalMonto;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Transacciones",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const ReportScreen(),
                        ),
                      );
                    },
                    shape: const CircleBorder(),
                    child: const Icon(CupertinoIcons.arrow_down_doc_fill),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 56, 136, 62),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: SegmentButton(
                          title: "Ingresos",
                          isActive: isIngresos,
                          onPressed: () {
                            setState(() {
                              isIngresos = !isIngresos;
                            });
                          })),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: SegmentButton(
                          title: "Egresos",
                          isActive: !isIngresos,
                          onPressed: () {
                            setState(() {
                              isIngresos = !isIngresos;
                            });
                          }))
                ],
              ),
            ),
            if (isIngresos)
              TransactionList(
                apiService: apiService,
                type: true,
                filtro: "ingreso",
              ),
            if (!isIngresos)
              TransactionList(
                apiService: apiService,
                type: true,
                filtro: "gasto",
              )
          ],
        ),
      ),
    );
  }
}
