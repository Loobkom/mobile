import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../models/product.dart';

class AddProductScreen extends StatelessWidget {
  static const routeName = '/add-product'; // Add this line

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
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
                final newProduct = Product(
                  id: DateTime.now().toString(),
                  name: _nameController.text,
                  description: _descriptionController.text,
                  price: int.parse(_priceController.text),
                );
                Provider.of<ProductsProvider>(context, listen: false)
                    .addProduct(newProduct);
                Navigator.of(context).pop();
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}