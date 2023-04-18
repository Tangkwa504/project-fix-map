import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Shopprofile extends StatefulWidget {
  const Shopprofile({super.key});

  @override
  State<Shopprofile> createState() => _ShopprofileState();
}

class _ShopprofileState extends State<Shopprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดร้านขายยา'),
      ),
    );
  }
}