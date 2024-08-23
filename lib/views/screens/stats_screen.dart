import 'package:flutter/material.dart';

import '../components/segment_button.dart';
import '../components/transaction_home_row.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  bool isIngresos = true;
  List ingresosArr = [
    {
      "categoria": "Trabajo1",
      "icono": "city-svgrepo-com",
      "colorCategoria": Colors.amber,
      "monto": "800",
    },
    {
      "categoria": "Trabajo2",
      "icono": "city-svgrepo-com",
      "colorCategoria": Colors.amber,
      "monto": "900",
    },
    {
      "categoria": "Inversion1",
      "icono": "city-svgrepo-com",
      "colorCategoria": Colors.amber,
      "monto": "150",
    },
    {
      "categoria": "Inversion2",
      "icono": "city-svgrepo-com",
      "colorCategoria": Colors.amber,
      "monto": "150",
    },
    {
      "categoria": "Cachuelo1",
      "icono": "city-svgrepo-com",
      "colorCategoria": Colors.amber,
      "monto": "100",
    },
    {
      "categoria": "Cachuelo2",
      "icono": "city-svgrepo-com",
      "colorCategoria": Colors.amber,
      "monto": "100",
    },
  ];

  List egresosArr = [
    {
      "categoria": "Universidad",
      "icono": "city-svgrepo-com",
      "colorCategoria": Colors.amber,
      "monto": "1000",
    },
    {
      "categoria": "Cita medica",
      "icono": "city-svgrepo-com",
      "colorCategoria": Colors.amber,
      "monto": "200",
    },
    {
      "categoria": "Casa",
      "icono": "city-svgrepo-com",
      "colorCategoria": Colors.amber,
      "monto": "300",
    },
    {
      "categoria": "Carro",
      "icono": "city-svgrepo-com",
      "colorCategoria": Colors.amber,
      "monto": "150",
    },
  ];

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
              ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ingresosArr.length,
                  itemBuilder: (context, index) {
                    var ingreso = ingresosArr[index] as Map? ?? {};
                    return TransactionsHomeRow(
                        transaccion: ingreso, onPressed: () {});
                  }),
            if (!isIngresos)
              ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: egresosArr.length,
                  itemBuilder: (context, index) {
                    var egreso = egresosArr[index] as Map? ?? {};
                    return TransactionsHomeRow(
                        transaccion: egreso, onPressed: () {});
                  }),
          ],
        ),
      ),
    );
  }
}
