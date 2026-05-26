import 'package:flutter/material.dart';

class CoreWidget extends StatelessWidget {
  const CoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, size: 30),
        ),

        title: Text(
          "Exercise 1 - Core Widgets demo",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Welcome to Flutter UI",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
                  textAlign: TextAlign.start,
                ),
                Icon(Icons.movie, color: Colors.blueAccent, size: 60.0),

                Image.asset(
                  "assets/images/highway.jpeg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                SizedBox(width: double.infinity, height: 20),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Icon(Icons.star, size: 30)),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Move Item",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                "This is a simple ListItem inside a Card",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
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
