import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomPieChart extends StatelessWidget {
  final double ingresos;
  final double egresos;

  const CustomPieChart({
    super.key,
    required this.ingresos,
    required this.egresos,
  });

  double sumarMontos(List arreglo) {
    double totalMonto = 0.0;
    for (var elemento in arreglo) {
      totalMonto += int.parse(elemento['monto']);
    }
    return totalMonto;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: PieChart(
          PieChartData(sections: [
            PieChartSectionData(
                value: ingresos,
                color: const Color.fromARGB(255, 56, 136, 62),
                radius: 60,
                titleStyle: const TextStyle(fontSize: 15),
                borderSide: const BorderSide(width: 2),
                badgeWidget: FloatingActionButton(
                    onPressed: () {},
                    mini: true,
                    backgroundColor: const Color.fromARGB(255, 56, 136, 62),
                    shape: const CircleBorder(),
                    child: const Icon(CupertinoIcons.bag_fill_badge_plus)),
                titlePositionPercentageOffset: 0.4,
                badgePositionPercentageOffset: 1,
            ),
            PieChartSectionData(
                value: egresos,
                color: const Color.fromARGB(255, 185, 87, 11),
                radius: 55,
                titleStyle: const TextStyle(fontSize: 15),
                borderSide: const BorderSide(width: 2),
                badgeWidget: FloatingActionButton(
                    onPressed: () {},
                    mini: true,
                    backgroundColor: const Color.fromARGB(255, 185, 87, 11),
                    shape: const CircleBorder(),
                    child: const Icon(CupertinoIcons.bag_fill_badge_minus)),
                titlePositionPercentageOffset: 0.4,
                badgePositionPercentageOffset: 1),
          ]),
        ),
      ),
    );
  }
}
