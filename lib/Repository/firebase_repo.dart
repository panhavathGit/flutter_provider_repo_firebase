import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_provider/Repository/repo.dart';
import '../Model/product.dart';

class FirebaseRepo extends ProductRepository{

  final CollectionReference _productsRef = FirebaseFirestore.instance.collection('products');
  @override
  Future<List<Product>> getProducts() async {
    final snapshot = await _productsRef.get();
    return snapshot.docs.map((doc) {
      return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  @override
  Future<void> addProduct(Product product) async{
    await _productsRef.add(product.toMap());
  }
  
  @override
  Future<void> updateProduct(String id, Product product) async{
    await _productsRef.doc(id).update(product.toMap());
  }
  @override
  Future<void> deleteProduct(String id) async{
    await _productsRef.doc(id).delete();
  }

}