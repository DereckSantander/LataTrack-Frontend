import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latatrack/views/components/transaction_home_row.dart';
import '../components/custom_pie_chart.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List transacciones = [
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
          Stack(children: [
            Container(
              height: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(188, 192, 213, 195),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomPieChart(
                    ingresos: sumarMontos(ingresosArr),
                    egresos: sumarMontos(egresosArr),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 56, 136, 62),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Text(
                              "Ingresos: \$${sumarMontos(ingresosArr)}",
                              //
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 185, 87, 11),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Text(
                              "Egresos: \$${sumarMontos(egresosArr)}",
                              //
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 40,
                  margin: const EdgeInsets.all(20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 56, 136, 62),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Text(
                    "Transaciones",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                  margin: const EdgeInsets.all(20),
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: SvgPicture.asset('assets/icon/filter-list-svgrepo-com.svg', height: 30, width: 30,
                    ),
                  ))
            ],
          ),
          ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: transacciones.length,
              itemBuilder: (context, index) {
                var transaccion = transacciones[index] as Map? ?? {};
                return TransactionsHomeRow(
                    transaccion: transaccion, onPressed: () {});
              }),
        ],
      ),
    ));
  }
}
