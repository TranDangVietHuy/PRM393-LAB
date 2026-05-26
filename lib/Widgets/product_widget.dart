import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        height: 800,
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.red),
        ),
        child: Column(
          children: <Widget>[
            //ảnh sp
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: 300,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: Image.asset(
                        "assets/images/img1.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: FloatingActionButton.extended(
                        onPressed: () {},
                        label: Text("Add to cart"),
                        icon: Icon(Icons.shopping_cart, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                flex: 3,

                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Gnome pilot doc"),
                            Text("Price: Priceless"),
                          ],
                        ),
                      ),
                      Icon(Icons.star),
                      Text("321"),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                flex: 1,

                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Text(
                        "In the GNOME desktop environment, power management for docking stations is handled by the GNOME Settings daemon. By default, GNOME assumes you want your laptop to stay running and output to an external monitor when the lid is closed and a dock or external display is connected.",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
