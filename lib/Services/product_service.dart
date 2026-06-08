import 'package:prj/Repositories/product_dao.dart';
import 'package:prj/entities/product.dart';

class ProductService {
  ProductDAO productDAO;
  List<Product>? products;
  ProductService({required this.productDAO}) {
    products = productDAO.getAllProduct();
  }

  List<Product> getAllProduct() {
    return products!;
  }
}
