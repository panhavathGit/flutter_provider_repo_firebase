import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_provider/Repository/repo.dart';
import '../Model/product.dart';
import '../DTO/product_dto.dart';

class FirebaseRepo extends ProductRepository{

  final CollectionReference _productsRef = FirebaseFirestore.instance.collection('products');

  @override
  Future<List<Product>> getProducts() async {
    final snapshot = await _productsRef.get();
    
    return snapshot.docs.map((doc) {
      final dto = ProductDTO.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      return dto.toModel();
    }).toList();
  }

  @override
  Future<void> addProduct(Product product) async{
    final dto = ProductDTO.fromModel(product);
    await _productsRef.add(dto.toFirestore());
  }
  
  @override
  Future<void> updateProduct(String id, Product product) async{
    final dto = ProductDTO.fromModel(product);
    await _productsRef.doc(id).update(dto.toFirestore());
  }
  @override
  Future<void> deleteProduct(String id) async{
    await _productsRef.doc(id).delete();
  }

}