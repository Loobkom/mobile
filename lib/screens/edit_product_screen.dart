import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../models/product.dart';

class EditProductScreen extends StatelessWidget {
  static const routeName = '/edit-product'; // Add this line

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    final product = Provider
        .of<ProductsProvider>(context)
        .products
        .firstWhere((prod) => prod.id == productId);

    _nameController.text = product.name;
    _descriptionController.text = product.description;
    _priceController.text = product.price.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                final updatedProduct = Product(
                  id: product.id,
                  name: _nameController.text,
                  description: _descriptionController.text,
                  price: int.parse(_priceController.text),
                );
                Provider.of<ProductsProvider>(context, listen: false)
                    .updateProduct(product.id, updatedProduct);
                Navigator.of(context).pop();
              },
              child: Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}