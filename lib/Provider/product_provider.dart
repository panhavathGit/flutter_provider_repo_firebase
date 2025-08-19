import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/product.dart';

class ProductsProvider extends ChangeNotifier {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('products');

  List<Product> products = [];

  // Load products once from Firestore
  Future<void> loadProducts() async {
    final snapshot = await _productsRef.get();
    products = snapshot.docs.map((doc) {
      return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
    notifyListeners();
  }

  // Add product to Firestore
  Future<void> addProduct(Product newProduct) async {
    await _productsRef.add(newProduct.toMap());
    await loadProducts();
  }

  // Update product in Firestore
  Future<void> updateProduct(int index, Product updatedProduct) async {
    final id = products[index].id!;
    await _productsRef.doc(id).update(updatedProduct.toMap());
    await loadProducts();
  }

  // Delete product from Firestore
  Future<void> deleteProduct(int index) async {
    final id = products[index].id!;
    await _productsRef.doc(id).delete();
    await loadProducts();
  }
}
