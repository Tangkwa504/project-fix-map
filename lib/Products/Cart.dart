import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Service.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    initproduct();
    super.initState();
  }

  void initproduct() {
    Future.delayed(const Duration(milliseconds: 500), () {
      final product = Provider.of<CartProvider>(context, listen: false);
      final seviceProvider = Provider.of<ProviderSer>(context, listen: false);
      product.getProductsInCart(seviceProvider.reademail);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final totalPrice = cartProvider.totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.products.length,
              itemBuilder: (context, index) {
                final product = cartProvider.products[index];
                return ListTile(
                  leading: Image.network(product.image),
                  title: Text(product.name),
                  subtitle: Text('${product.price} บาท x ${product.quantity} ชุด'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      final seviceProvider =
                          Provider.of<ProviderSer>(context, listen: false);
                      cartProvider.removeProduct(
                          product, seviceProvider.reademail);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Price: ${totalPrice.toStringAsFixed(2)} บาท',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
