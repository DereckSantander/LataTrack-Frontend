import 'package:flutter/material.dart';

class Categorias {
  static Map<IconData, String> iconosDisponibles = {
    Icons.shopping_cart: 'Icons.shopping_cart',
    Icons.directions_car: "Icons.directions_car",
    Icons.home: "Icons.home",
    Icons.movie: "Icons.movie",
    Icons.local_hospital: "Icons.local_hospital",
    Icons.airplane_ticket: 'Icons.airplane_ticket',
    Icons.school: "Icons.school",
    Icons.beach_access: "Icons.beach_access",
    Icons.savings: "Icons.savings",
    Icons.attach_money: "Icons.attach_money"
  };

  static IconData fromString(String iconoBuscado) {
    for (final entry in iconosDisponibles.entries) {
      if (entry.value == iconoBuscado) {
        return entry.key;
      }
    }
    return Icons.error;
  }
}
