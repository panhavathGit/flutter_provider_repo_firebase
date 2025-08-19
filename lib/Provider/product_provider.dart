import 'package:fire_provider/Repository/repo.dart';
import 'package:flutter/material.dart';
import '../Model/product.dart';

class ProductsProvider extends ChangeNotifier {
  final ProductRepository repository;

  ProductsProvider({required this.repository});

  List<Product> products = [];

  // Load products once from Firestore
  Future<void> loadProducts() async {
    products = await repository.getProducts();
    notifyListeners();
  }

  // Add product to Firestore
  Future<void> addProduct(Product newProduct) async {
    await repository.addProduct(newProduct);
    await loadProducts();
  }

  // Update product in Firestore
  Future<void> updateProduct(int index, Product updatedProduct) async {
    final id = products[index].id!;
    await repository.updateProduct(id,updatedProduct);
    await loadProducts();
  }

  // Delete product from Firestore
  Future<void> deleteProduct(int index) async {
    final id = products[index].id!;
    await repository.deleteProduct(id);
    await loadProducts();
  }
}
