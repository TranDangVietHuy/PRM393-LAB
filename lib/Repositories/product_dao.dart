import 'package:prj/entities/product.dart';

class ProductDAO {
  List<Product>? products = [
    Product(
      id: "P001",
      name: "Laptop",
      price: 1200.0,
      image: "images/laptop.png",
      description: "High-performance laptop for professionals and gaming",
    ),
    Product(
      id: "P002",
      name: "Phone",
      price: 800.0,
      image: "images/phone.png",
      description: "Latest smartphone with advanced camera and fast processor",
    ),
    Product(
      id: "P003",
      name: "Tablet",
      price: 450.0,
      image: "images/tablet.png",
      description:
          "Portable tablet with stunning display and long battery life",
    ),
    Product(
      id: "P004",
      name: "Headphones",
      price: 120.0,
      image: "images/headphones.png",
      description: "Premium wireless headphones with noise cancellation",
    ),
    Product(
      id: "P005",
      name: "Smart Watch",
      price: 250.0,
      image: "images/watch.png",
      description: "Smart watch with fitness tracking and health monitoring",
    ),
  ];



  /// Get all products
  List<Product> getAllProduct() {
    return products!;
  }

  /// Get product by ID
  Product? findById(String id) {
    try {
      return products!.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Search products by name
  List<Product> searchByName(String name) {
    return products!
        .where(
          (product) => product.name.toLowerCase().contains(name.toLowerCase()),
        )
        .toList();
  }

  /// Add new product
  void addProduct(Product product) {
    var index = products!.indexWhere((element) => element.id == product.id);
    if (index < 0) products!.add(product);
  }

  /// Update product
  void updateProduct(Product pNew) {
    var index = products!.indexWhere((element) => element.id == pNew.id);
    if (index != -1) {
      products![index] = pNew;
    }
  }

  /// Delete product by ID
  void deleteProduct(String id) {
    products!.removeWhere((element) => element.id == id);
  }

  /// Get total products count
  int getCount() {
    return products!.length;
  }

  /// Increase all product prices by percentage
  void increasePrice(double percentage) {
    for (int i = 0; i < products!.length; i++) {
      double newPrice = products![i].price * (1 + (percentage / 100));
      products![i] = Product(
        id: products![i].id,
        name: products![i].name,
        price: newPrice,
        image: products![i].image,
      );
    }
  }

  /// Sort products by price (ascending)
  List<Product> sortByPrice() {
    List<Product> sorted = [...products!];
    sorted.sort((a, b) => a.price.compareTo(b.price));
    return sorted;
  }

  /// Sort products by name
  List<Product> sortByName() {
    List<Product> sorted = [...products!];
    sorted.sort((a, b) => a.name.compareTo(b.name));
    return sorted;
  }
}
