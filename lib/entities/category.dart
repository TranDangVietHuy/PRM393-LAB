import 'product.dart';

class Category {
  final int id;
  final String name;
  final String des;
  List<Product>? products;

  Category({
    required this.id,
    this.name = '',
    this.des = '',
    this.products,
  });
  Category copyTo({
    int? id,
    String? name,
    String? des,
    List<Product>? products,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      des: des ?? this.des,
      products: products ?? this.products,
    );
  }

  void addProduct(Product p) {
    products!.add(p);
  }

  void removeProduct(Product p) {
    products!.remove(p);
  }
}
