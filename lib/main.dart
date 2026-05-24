import 'package:flutter/material.dart';
import 'package:prj/Views/HomePage.dart';
import 'package:prj/entities/Product.dart';

void main() {
  final productManager = Product(
    id: "P006",
    name: "Samsung Z fold 7",
    price: 2400,
    image: "assets/images/fold7.png",
  );

  productManager.add(productManager);

  final importedProduct = Product.fromJson({
    "id": "P007",
    "name": "iPad Pro",
    "price": 1299,
    "image": "assets/images/ipad.png",
  });
  productManager.add(importedProduct);

  productManager.edit(
    "P006",
    name: "Samsung Z fold 7 Ultra",
    price: 2500,
    image: "assets/images/fold7-ultra.png",
  );

  productManager.increasePriceOneProduct("P006");
  productManager.increasePriceAll();

  final searchResults = productManager.search("Samsung");
  final sortedProducts = productManager.sortProducts(criteria: "name");

  Product.products.firstWhere((product) => product.id == "P006").printProduct();
  debugPrint(
    'Search results: ${searchResults.map((product) => product.name).join(", ")}',
  );
  debugPrint(
    'Sorted products: ${sortedProducts.map((product) => product.name).join(", ")}',
  );

  productManager.delete("P007");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
