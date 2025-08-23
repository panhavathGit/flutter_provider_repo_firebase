import '../Model/product.dart';

class ProductDTO {
	final String? id;
	final String name;
	final double price;

	ProductDTO({this.id, required this.name, required this.price});

	// Create DTO from Firestore data
	factory ProductDTO.fromFirestore(Map<String, dynamic> data, String documentId) {
		return ProductDTO(
			id: documentId,
			name: data['name'] ?? '',
			price: (data['price'] as num).toDouble(),
		);
	}

	// Convert DTO to Firestore map
	Map<String, dynamic> toFirestore() {
		return {
			'name': name,
			'price': price,
		};
	}

	// Convert DTO to domain model
	Product toModel() {
		return Product(id: id, name: name, price: price);
	}

	// Create DTO from domain model
	factory ProductDTO.fromModel(Product product) {
		return ProductDTO(id: product.id, name: product.name, price: product.price);
	}
}
