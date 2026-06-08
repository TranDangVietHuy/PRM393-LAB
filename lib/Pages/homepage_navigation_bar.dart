import 'package:flutter/material.dart';
import 'package:prj/Pages/about_page.dart';
import 'package:prj/Widgets/about_widget.dart';
import 'package:prj/Widgets/product_list.dart';
import 'package:prj/entities/product.dart';

class HomepageNavigationBar extends StatefulWidget {
  // final List<Product> products;

  const HomepageNavigationBar({super.key});

  @override
  State<HomepageNavigationBar> createState() => _HomepageNavigationBarState();
}

class _HomepageNavigationBarState extends State<HomepageNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const ProductList(),
        const AboutWidget(),
        const AboutPage(),
      ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amberAccent,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.details), label: "details"),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "about",
          ),
        ],
      ),
    );
  }
}
