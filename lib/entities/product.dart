import 'package:flutter/foundation.dart';

// /*LAB 1
//  * Xây dựng lớp Product với các thuộc tính id, name, price, image
//  * có các thuộc tính và danh sách tĩnh gồm List<Product> products
//  * ( gán cho 1 số các giá trị mặc định) và xây dựng các phương thức sau:
//  *   - Phương thức khởi tạo, phương thức factory để map một Json về Product
//  *   - Phương thức add(product), edit(product), search(name),
//  *   increasePrice(tăng giá mỗi sp lên 10%), dùng decarative-map)
//  *   find,...
//  *  để hiển thi, sắp xếp, thêm, xóa sửa , tìm kiếm
//  */

class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String? description;
  static List<Product> products = [
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
  Product({
    required this.id,
    required this.name,
    required this.price,
    this.image = "",
    this.description,
  });
  Product copyTo({
    String? id,
    String? name,
    double? price,
    String? image,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, image: $image, description: $description)';
  }

  void printProduct() {
    debugPrint(toString());
  }

  static void _validateText(String value, String fieldName) {
    if (value.trim().isEmpty) {
      debugPrint('$fieldName cannot be empty');
    }
  }

  static int _productIndexById(String id) {
    _validateText(id, 'id');
    return products.indexWhere((p) => p.id == id);
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') ||
        !json.containsKey('name') ||
        !json.containsKey('price')) {
      debugPrint('Missing required product fields');
    }
    return Product(
      id: json['id'].toString(),
      name: json['name'].toString(),
      price: double.parse(json['price'].toString()),
      image: json['image']?.toString() ?? '',
      description: json['description']?.toString(),
    );
  }

  void add(Product p) {
    _validateText(p.id, 'id');
    _validateText(p.name, 'name');
    if (p.price < 0) {
      debugPrint('price cannot be negative');
    }
    if (products.any((product) => product.id == p.id)) {
      debugPrint('A product with id ${p.id} already exists');
    }
    products.add(p);
  }

  void delete(String id) {
    final index = _productIndexById(id);
    if (index == -1) {
      debugPrint('Product with id $id was not found');
    }
    products.removeAt(index);
  }

  void edit(
    String id, {
    String? name,
    double? price,
    String? image,
    String? description,
  }) {
    final index = _productIndexById(id);
    if (index == -1) {
      debugPrint('Product with id $id was not found');
    }

    if (name != null) {
      _validateText(name, 'name');
    }
    if (price != null && price < 0) {
      debugPrint('price cannot be negative');
    }

    products[index] = products[index].copyTo(
      name: name,
      price: price,
      image: image,
      description: description,
    );
  }

  List<Product> search(String keyword) {
    _validateText(keyword, 'keyword');
    return products
        .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  void increasePriceOneProduct(String id) {
    final index = _productIndexById(id);
    if (index == -1) {
      debugPrint('Product with id $id was not found');
    }

    products[index] = products[index].copyTo(
      price: double.parse((products[index].price * 1.1).toStringAsFixed(2)),
    );
  }

  void increasePriceAll() {
    products = products
        .map(
          (s) => Product(
            id: s.id,
            name: s.name,
            price: double.parse((s.price * 1.1).toStringAsFixed(2)),
            image: s.image,
          ),
        )
        .toList();
  }

  List<Product> sortProducts({String? criteria, bool sortAsc = true}) {
    final int sortOrder = sortAsc ? 1 : -1;
    List<Product> sorted = products;
    sorted.sort((a, b) {
      dynamic aValue = (criteria == "price")
          ? a.price
          : (criteria == "name")
          ? a.name
          : a.id;

      dynamic bValue = (criteria == "price")
          ? b.price
          : (criteria == "name")
          ? b.name
          : b.id;

      return aValue.compareTo(bValue) * sortOrder;
    });

    return sorted;
  }
}
