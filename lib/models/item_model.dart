
class Item {
  final int id;
  final String name;
  final String category;
  final double price;
  final bool inStock;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.inStock,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'].toDouble(),
      inStock: json['in_stock'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'in_stock': inStock ? 1 : 0,
    };
  }
}
