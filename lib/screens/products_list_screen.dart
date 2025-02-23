import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../models/product.dart';
import 'add_product_screen.dart'; // Import the AddProductScreen
import 'edit_product_screen.dart'; // Import the EditProductScreen

class ProductsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = productsProvider.products;

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(products[i].name),
          subtitle: Text(products[i].description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Edit button
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Navigate to edit product screen
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routeName, // Use the route name
                    arguments: products[i].id, // Pass the product ID as an argument
                  );
                },
              ),
              // Delete button with confirmation dialog
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Show confirmation dialog before deleting
                  _showDeleteConfirmationDialog(context, productsProvider, products[i].id);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add product screen
          Navigator.of(context).pushNamed(AddProductScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Function to show the confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context, ProductsProvider productsProvider, String productId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Product'),
        content: Text('Are you sure you want to delete this product?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Perform the deletion and close the dialog
              productsProvider.deleteProduct(productId);
              Navigator.of(ctx).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
