import 'package:fire_provider/Model/product.dart';

abstract class ProductRepository{
  Future<List<Product>> getProducts();
  Future<void> addProduct(Product product);
  Future<void> updateProduct(String id, Product product);
  Future<void> deleteProduct(String id);
}