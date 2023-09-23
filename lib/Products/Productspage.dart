import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../model/Products.dart';
import '../widgets/Service.dart';
import 'Addproducts.dart';
import 'ProductDetails.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    initproduct();
    super.initState();
  }
  void initproduct() {
    Future.delayed(const Duration(milliseconds: 500), () {
    final product = Provider.of<ProductProvider>(context, listen: false);
    final seviceProvider = Provider.of<ProviderSer>(context, listen: false);
    product.initProducts(seviceProvider.reademail);  
});
      
  } 

  @override
  Widget build(BuildContext context) {
    final List<Product> products =
        Provider.of<ProductProvider>(context).products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(product.image),
            title: Text(product.name),
            subtitle: Text('${product.price.toStringAsFixed(2)}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addproduct(),
                ),
              );
          },
        child: const Icon(Icons.add),
      ),
    );

  }
}