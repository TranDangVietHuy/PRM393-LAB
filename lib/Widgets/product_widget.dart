import 'package:flutter/material.dart';
import 'package:prj/entities/product.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductWidget({super.key, required this.product, this.onTap});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  late Product product;
  bool isLike = false;

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //ảnh sp
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: widget.onTap,
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth <= 1000
                ? constraints.maxWidth
                : constraints.maxWidth / 2,
            child: Column(
              children: [
                //ảnh sp
                Expanded(
                  flex: 6,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(product.image, fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.price.toStringAsFixed(0),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF9E9C9C),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isLike = !isLike;
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  color: isLike ? Colors.yellow : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\$${product.price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF534AB7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.description?.isNotEmpty == true
                          ? product.description!
                          : "Premium quality product",
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class ProductWidget extends StatelessWidget {
//   const ProductWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
