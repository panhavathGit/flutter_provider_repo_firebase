class Product {
  String? id; // Firestore document ID
  String name;
  double price;

  Product({this.id, required this.name, required this.price});

  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      name: data['name'] ?? '',
      price: (data['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}