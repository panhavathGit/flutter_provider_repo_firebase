import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/product.dart';
import '../Provider/product_provider.dart';
class ProviderForm extends StatefulWidget {
  final Product? product;
  final int? productIndex;
  const ProviderForm({super.key, this.product, this.productIndex});

  @override
  State<ProviderForm> createState() => _ProviderFormState();
}

class _ProviderFormState extends State<ProviderForm> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController ;
  late TextEditingController priceController ;

  // void submit(){
  //   if(formKey.currentState!.validate()){
  //     final newProduct = Product(
  //       name: nameController.text,
  //       price: double.parse(priceController.text),
  //     );

  //     final productProvider = context.read<ProductsProvider>();

  //     if(widget.product == null){
  //       productProvider.addProduct(newProduct);
  //     }else{
  //       productProvider.updateProduct(widget.productIndex!, newProduct);
  //     }
  //     Navigator.pop(context);
  //   }
  // }

  Future<void> submit() async {
  if (formKey.currentState!.validate()) {
    final newProduct = Product(
      name: nameController.text,
      price: double.parse(priceController.text),
    );

    final productProvider = context.read<ProductsProvider>();

    if (widget.product == null) {
      await productProvider.addProduct(newProduct);
    } else {
      await productProvider.updateProduct(widget.productIndex!, newProduct);
    }

    if (!mounted) return; // check widget still in tree
    Navigator.pop(context);
  }
}


  @override
  void initState(){
    super.initState();
    if(widget.product?.name != null && widget.product?.price != null){
        nameController = TextEditingController(text: widget.product?.name);
        priceController = TextEditingController(text: '${widget.product?.price}');
    }else{
      nameController = TextEditingController(text: '');
      priceController = TextEditingController(text: '');
    }
  }

  @override
  void dispose(){
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'please input name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText:'Name',
                  icon: Icon(Icons.abc)
                ),
              ),
              TextFormField(
                controller: priceController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'input a valid number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText:'Price',
                  icon: Icon(Icons.price_change)
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton(onPressed: submit, child: Text(isEditing? 'Update Product' :'Add Product'))
            ],
          )),
      ),
    );
  }
}