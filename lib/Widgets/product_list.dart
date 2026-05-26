import 'package:flutter/material.dart';


import 'package:prj/Widgets/product_widget.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (int i = 1; i <= 5; i++)
          Padding(padding: const EdgeInsets.all(8.0), child: ProductWidget()),

      ],
    );
  }
}
