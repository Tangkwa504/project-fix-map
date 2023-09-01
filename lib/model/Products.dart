class Product {
  final String name;
  final String image;
  final double price;
  final String date;
  int quantity;
  

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.date,
    required this.quantity,
  });

  Product copyWith({
    String? name,
    String? image,
    double? price,
    int? quantity,
    String? date,
  }) {
    return Product(
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      image: json['image'],
      price: json['price'].toDouble(),
      quantity: json['quantity'] ?? 1,
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'date': date,
    };
  }
}
