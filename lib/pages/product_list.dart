import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Pages/form.dart';  // Your existing form screen
import '../Provider/product_provider.dart';

class ProviderProList extends StatelessWidget {
  const ProviderProList({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductsProvider>().products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product list by Provider"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProviderForm()));
            },
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProviderForm(
                          product: p,
                          productIndex: index,
                        ),
                      ),
                    );
                  },
                  title: Text(p.name),
                  subtitle: Text('${p.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<ProductsProvider>().deleteProduct(index);
                    },
                  ),
                );
              },
            ),
    );
  }
}
