import 'package:flutter/material.dart';
import 'package:prj/Pages/product_detail.dart';
import 'package:prj/Repositories/product_dao.dart';
import 'package:prj/ViewModel/product_view_model.dart';

import 'package:prj/entities/product.dart';
import 'package:prj/Widgets/product_widget.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late final ProductViewModel viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    viewModel = ProductViewModel(productDAO: ProductDAO(),);
    viewModel.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GridView.count(
        //B2: điều chỉnh layoy hiển thị Widget hiển thị sp
        crossAxisCount: MediaQuery.of(context).size.width <= 450 ? 1 : 2,
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          for (final product in viewModel.products)
            ProductWidget(
              product: product,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (content) => ProductDetailPage(product: product),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class ProductListResponsive extends StatelessWidget {
  final List<Product> products;
  
  const ProductListResponsive({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GridView.count(
        //B2: điều chỉnh layoy hiển thị Widget hiển thị sp
        crossAxisCount: MediaQuery.of(context).size.width <= 450 ? 1 : 2,
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          for (final product in products)
            ProductWidget(
              product: product,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (content) => ProductDetailPage(product: product),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

// class ProductList extends StatelessWidget {
//   ProudctList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         for (int i = 1; i <= 5; i++)
//           Padding(padding: const EdgeInsets.all(8.0), child: ProductWidget(product: prod,)),

//       ],
//     );
//   }
// }
