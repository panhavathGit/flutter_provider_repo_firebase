class Product {
  String? id; // Firestore document ID
  String name;
  double price;

  Product({this.id, required this.name, required this.price});

}