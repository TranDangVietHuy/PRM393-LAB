import 'package:flutter/material.dart';

class AppStructureDemo extends StatefulWidget {
  const AppStructureDemo({super.key});

  @override
  State<AppStructureDemo> createState() => _AppStructureDemoState();
}

class _AppStructureDemoState extends State<AppStructureDemo> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Exercise 4 - App Structure Demo",
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          const Padding(
            padding: EdgeInsetsDirectional.only(end: 6),
            child: Center(child: Text("Dark")),
          ),
          Switch(
            value: isDark,
            onChanged: (value) {
              setState(() {
                isDark = value;
              });
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: isDark ? Colors.black12 : const Color(0xFFF6F1FA),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              "This is a simple screen with theme toggle.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
