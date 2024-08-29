import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:latatrack/globals.dart';
import 'package:latatrack/services/api_service.dart';
import 'package:latatrack/src/models.dart';
import 'package:intl/intl.dart';
import 'package:latatrack/src/Categorias.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final ApiService apiService = ApiService(ipApi);

  static TextEditingController categoriaController = TextEditingController();
  TextEditingController montoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController fechaController = TextEditingController();

  TextEditingController nombreNuevaCategoriaController = TextEditingController();
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

  IconData? miIcono;
  String? selectedIconName;
  Color? colorCategoriaNueva;

  IconData? iconoCategoriaEscogida;
  static bool mostrarCategorias = false;

  Future<List<Category>>? categoriasFuture;
  String filtroCategorias = "";

  Category? categoriaEscogida;

  void updateCategorias(String tipo) {
    setState(
      () {
        filtroCategorias = tipo;
        categoriaController.text = "";
        mostrarCategorias = true;
        categoriasFuture = apiService.fetchCategoriesByType(tipo);
      },
    );
  }

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
              IngresoEgresoButtons(
                onIngresoSelected: () => updateCategorias("ingreso"),
                onEgresoSelected: () => updateCategorias("gasto"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                readOnly: true,
                onTap: () {
                  setState(() {
                    mostrarCategorias = !mostrarCategorias;
                    categoriasFuture = apiService.fetchCategoriesByType(filtroCategorias);
                    montoController.text = "";
                    descripcionController.text = "";
                    fechaController.text = "";
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
                                          controller: nombreNuevaCategoriaController,
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
                                                        pickerColor: colorCategoriaNueva,
                                                        onColorChanged: (value) {
                                                          setState(
                                                            () {
                                                              colorCategoriaNueva = value;
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
                                            color: colorCategoriaNueva,
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
                                                itemCount: Categorias.iconosDisponibles.length,
                                                itemBuilder: (context, int i) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        miIcono = Categorias.iconosDisponibles.keys.toList()[i];
                                                        selectedIconName = Categorias.iconosDisponibles[miIcono];
                                                        print(selectedIconName);
                                                      });
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.all(1.0),
                                                      decoration: BoxDecoration(
                                                        color: miIcono == Categorias.iconosDisponibles.keys.toList()[i]
                                                            ? colorCategoriaNueva
                                                            : Colors.white,
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
                                                        Categorias.iconosDisponibles.keys.toList()[i],
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
                                              onPressed: () async {
                                                Navigator.pop(ctx);
                                                String colorNuevo =
                                                    "#${colorCategoriaNueva!.value.toRadixString(16).substring(2).toUpperCase()}";
                                                await apiService.createCategory(
                                                    nombreNuevaCategoriaController.text,
                                                    isIngresoSelected && !isEgresoSelected ? "ingreso" : "gasto",
                                                    colorNuevo,
                                                    selectedIconName!);
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
              if (mostrarCategorias)
                FutureBuilder<List<Category>>(
                  future: categoriasFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No hay categorías disponibles.'));
                    } else {
                      final categorias = snapshot.data!;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: categorias.length,
                          itemBuilder: (context, index) {
                            final categoria = categorias[index];
                            return ListTile(
                              title: Text(categoria.name),
                              onTap: () {
                                setState(() {
                                  categoriaController.text = categoria.name;
                                  categoriaEscogida = categoria;
                                });
                              },
                              leading: Container(
                                decoration: BoxDecoration(
                                  color: ColorHelper.fromHex(categoria.color),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Icon(Categorias.fromString(categoria.icono), color: Colors.black),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
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
                          onPressed: () {
                            print(fechaEscogida);
                            apiService.createTransaction(double.parse(montoController.text), descripcionController.text,
                                categoriaEscogida!.id, DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').format(fechaEscogida));
                          },
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
  final VoidCallback onIngresoSelected;
  final VoidCallback onEgresoSelected;

  const IngresoEgresoButtons({
    Key? key,
    required this.onIngresoSelected,
    required this.onEgresoSelected,
  }) : super(key: key);

  @override
  _IngresoEgresoButtonsState createState() => _IngresoEgresoButtonsState();
}

class _IngresoEgresoButtonsState extends State<IngresoEgresoButtons> {
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
              widget.onIngresoSelected();
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
              widget.onEgresoSelected();
            },
            child: const Text("Egreso"),
          ),
        ),
      ],
    );
  }
}

class ColorHelper {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 7) buffer.write('ff'); // Si es un código de color hexadecimal (sin alfa)
    buffer.write(hexString.replaceAll('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
