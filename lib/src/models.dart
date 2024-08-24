class Transaction {
  final int id;
  final String amount;
  final String description;
  final DateTime created;
  final int categoryId;
  final int report;

  Transaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.created,
    required this.categoryId,
    required this.report,
  });
}

class Category {
  final int id;
  final String name;
  final String type;
  final String color;
  final String icono;
  final DateTime created;

  Category({
    required this.id,
    required this.name,
    required this.type,
    required this.color,
    required this.icono,
    required this.created,
  });
}
