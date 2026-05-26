import 'package:flutter/material.dart';
import 'package:prj/Lab4/app_structure_demo.dart';
import 'package:prj/Lab4/core_widgets_demo.dart';
import 'package:prj/Lab4/common_ui_demo.dart';
import 'package:prj/Lab4/input_control_demo.dart';
import 'package:prj/Lab4/layout_demo.dart';

const String homeTitle = "Lab4 - Flutter UI Fundamentals";
const List menus = [
  {"title": "Exercise 1 - Core Widgets Demo", "navigation": CoreWidget()},
  {"title": "Exercise 2 - Input Controls Demo", "navigation": InputControl()},
  {"title": "Exercise 3 - Layout Demo", "navigation": LayoutDemo()},
  {"title": "Exercise 4 - App Structure Demo","navigation": AppStructureDemo(),},
  {"title": "Exercise 5 - Common UI Demo", "navigation": CommonUIDemo()},
];

class Lab4HomePage extends StatelessWidget {
  const Lab4HomePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homeTitle, style: TextStyle(fontSize: 25)),
        actions: [
          IconButton(
            onPressed: onThemeToggle,
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            for (int i = 0; i < menus.length; i++)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: InkWell(
                    onTap: () {
                      final page = menus[i]["navigation"];
                      if (page != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => page),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: Text(
                              menus[i]["title"],
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Spacer(),
                          Flexible(
                            child: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ],
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
