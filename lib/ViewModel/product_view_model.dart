import 'package:flutter/foundation.dart';
import 'package:prj/Repositories/product_dao.dart';
import 'package:prj/entities/product.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductDAO productDAO;

  ProductViewModel({required this.productDAO});

  List <Product> _products = [];
  String  _searchKeyword = "";

  List <Product> get products => _products;
  String get searchKeyword => _searchKeyword;
  void loadProducts() {
    _products = productDAO.getAllProduct();
    notifyListeners();
  }

  void searchProducts(String keyword){
    _searchKeyword = keyword;

    if(keyword.trim().isEmpty){
      _products = productDAO.getAllProduct();
    }
    else{
      _products = productDAO.searchByName(keyword);
    }

    notifyListeners();
  }

  void addProduct(Product product) {
    productDAO.addProduct(product);
    loadProducts();
  }

  void deleteProduct(String id) {
    productDAO.deleteProduct(id);
    loadProducts();
  }

  Product? getProductById(String id){
    return productDAO.findById(id);
  }
}