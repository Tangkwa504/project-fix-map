import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Product 1",
      "price": 10.99,
      "quantity": 2,
      "imageUrl": "https://ocs-k8s-prod.s3.ap-southeast-1.amazonaws.com/PRODUCT_1619081525308.jpeg",
    },
    {
      "id": 2,
      "name": "Product 2",
      "price": 5.99,
      "quantity": 1,
      "imageUrl": "https://example.com/product2.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตระกร้ายา'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          final item = cartItems[index];

          return ListTile(
            leading: Image.network(
              item["imageUrl"],
              width: 50,
            ),
            title: Text(item["name"]),
            subtitle: Text('ราคา: ${item["price"]} บาท, จำนวน: ${item["quantity"]}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  cartItems.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${_calculateTotal().toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // handle checkout
              },
              child: Text('ชำระเงิน'),
              
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotal() {
    double total = 0.0;

    for (var item in cartItems) {
      total += (item["price"] * item["quantity"]);
    }

    return total;
  }
}
