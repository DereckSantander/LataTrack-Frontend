import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  TextEditingController categoriaController = TextEditingController();
  TextEditingController montoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  late DateTime fechaEscogida;

  List<Color> listaColores = [
    Colors.orange,
    Colors.teal,
    Colors.red,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.brown,
    Colors.pink,
  ];

  List<IconData> listaIconos = [
    Icons.food_bank,
    Icons.abc,
  ];

  Map<IconData, String> iconMap = {
    Icons.airplane_ticket: 'Icons.airplane_ticket',
  };

  IconData? miIcono;
  String? selectedIconName;
  Color? colorCategoria;

  IconData? iconoCategoriaEscogida;
  bool mostrarCategorias = true;

  Map<String, String> iconosCargados = {
    "Icons.food_bank": "#00000", // black
    "Icons.abc": "#FF0000" // red
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Agregar transacción",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              IngresoEgresoButtons(),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                readOnly: true,
                onTap: () {
                  setState(() {
                    mostrarCategorias = !mostrarCategorias;
                  });
                },
                controller: categoriaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: mostrarCategorias
                          ? const BorderRadius.vertical(top: Radius.circular(20))
                          : BorderRadius.circular(20)),
                  prefixIcon: const Icon(
                    Icons.list,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              bool menuMostrado = false;
                              return StatefulBuilder(builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text(
                                    "Nueva categoría",
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            hintText: "Nombre de categoría",
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (ctx2) {
                                                return AlertDialog(
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      const Text(
                                                        "Color de categoría:",
                                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                      ),
                                                      BlockPicker(
                                                        pickerColor: colorCategoria,
                                                        onColorChanged: (value) {
                                                          setState(
                                                            () {
                                                              colorCategoria = value;
                                                            },
                                                          );
                                                        },
                                                        availableColors: listaColores,
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        height: 50,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(ctx2);
                                                          },
                                                          style: TextButton.styleFrom(
                                                            backgroundColor: Color.fromARGB(255, 33, 49, 64),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)),
                                                          ),
                                                          child: const Text(
                                                            "Seleccionar",
                                                            style: TextStyle(fontSize: 22, color: Colors.white),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.circle,
                                            color: colorCategoria,
                                          ),
                                          isDense: true,
                                          filled: true,
                                          hintText: "Color",
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        onTap: () {
                                          setState(
                                            () {
                                              menuMostrado = !menuMostrado;
                                            },
                                          );
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: const Icon(
                                            Icons.arrow_drop_down,
                                            size: 12,
                                          ),
                                          isDense: true,
                                          filled: true,
                                          hintText: "Ícono",
                                          border: OutlineInputBorder(
                                              borderRadius: menuMostrado
                                                  ? const BorderRadius.vertical(top: Radius.circular(20))
                                                  : BorderRadius.circular(20)),
                                        ),
                                      ),
                                      menuMostrado
                                          ? Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 200,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(255, 33, 49, 64),
                                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                                              ),
                                              child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                                itemCount: listaIconos.length,
                                                itemBuilder: (context, int i) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        miIcono = listaIconos[i];
                                                        selectedIconName = iconMap[miIcono];
                                                        print(selectedIconName);
                                                      });
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.all(1.0),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            miIcono == listaIconos[i] ? colorCategoria : Colors.white,
                                                        borderRadius: BorderRadius.circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black.withOpacity(0.1),
                                                            spreadRadius: 2,
                                                            blurRadius: 5,
                                                          ),
                                                        ],
                                                      ),
                                                      margin:
                                                          const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                                                      child: Icon(
                                                        listaIconos[i],
                                                        size: 40,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(ctx);
                                                print(
                                                    colorCategoria?.value.toRadixString(16).substring(2).toUpperCase());
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: Color.fromARGB(255, 33, 49, 64),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              ),
                                              child: const Text(
                                                "Agregar",
                                                style: TextStyle(fontSize: 20, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                            });
                      },
                      icon: const Icon(Icons.add, size: 20)),
                  hintText: "Categoría",
                ),
              ),
              mostrarCategorias
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 33, 49, 64),
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                      ),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                        ),
                        itemCount: iconosCargados.length,
                        itemBuilder: (context, int i) {
                          String iconName = listaIconos[i].toString();
                          String iconColorHex = iconosCargados[iconName] ?? "#FFFFFF"; // Default to white if not found
                          // Convert the hex color string to a Color object
                          Color iconColor = Color(int.parse(iconColorHex.replaceFirst('#', '0xFF')));

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                iconoCategoriaEscogida = listaIconos[i];
                                selectedIconName = iconName;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(1.0),
                              decoration: BoxDecoration(
                                color: iconoCategoriaEscogida == listaIconos[i] ? Colors.red : iconColor,
                                //miIcono == listaIconos[i]? Colors.red: Colors.white
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                              child: Icon(
                                listaIconos[i],
                                size: 40,
                                color: Colors.black, // Use the color from the map
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: montoController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.attach_money,
                    size: 20,
                  ),
                  hintText: "Monto",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descripcionController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.description_outlined,
                    size: 20,
                  ),
                  hintText: "Descripción",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: fechaController,
                onTap: () async {
                  final DateTime now = DateTime.now();
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: DateTime(now.year),
                    lastDate: DateTime(now.year + 1).subtract(const Duration(days: 1)),
                  );

                  if (newDate != null) {
                    fechaEscogida = newDate;
                    fechaController.text = "${newDate.toLocal()}".split(' ')[0];
                  }
                },
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                  ),
                  hintText: "Fecha",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 33, 49, 64),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Guardar",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IngresoEgresoButtons extends StatefulWidget {
  @override
  _IngresoEgresoButtonsState createState() => _IngresoEgresoButtonsState();
}

class _IngresoEgresoButtonsState extends State<IngresoEgresoButtons> {
  bool isIngresoSelected = false;
  bool isEgresoSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Botón de Ingreso
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isIngresoSelected ? Colors.green : Colors.white,
              foregroundColor: isIngresoSelected ? Colors.white : Colors.green,
              side: const BorderSide(color: Colors.green),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              setState(() {
                isIngresoSelected = true;
                isEgresoSelected = false;
              });
            },
            child: const Text("Ingreso"),
          ),
        ),
        const SizedBox(width: 8.0),
        // Botón de Egreso
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isEgresoSelected ? Colors.red : Colors.white,
              foregroundColor: isEgresoSelected ? Colors.white : Colors.red,
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              setState(() {
                isIngresoSelected = false;
                isEgresoSelected = true;
              });
            },
            child: const Text("Egreso"),
          ),
        ),
      ],
    );
  }
}
