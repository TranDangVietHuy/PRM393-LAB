import 'package:flutter/material.dart';
import 'package:prj/Pages/about_page.dart';
import 'package:prj/Pages/homepage_navigation_bar.dart';
import 'package:prj/entities/product.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   '/': (context) => HomePage(),
      //   '/about': (context) => AboutPage(),
      // },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomepageNavigationBar(
        
        // isDarkMode: isDarkMode,
        // onThemeToggle: () {
        //   setState(() {
        //     isDarkMode = !isDarkMode;
        //   });
        // },
      ),

      routes: {'/about': (context) => const AboutPage()},
    );
  }
}
