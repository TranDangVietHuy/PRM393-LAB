import 'package:flutter/material.dart';

final String title = "Now Playing";
List playingList = [
  {"title": "Avatar", "description": "Sample description"},
  {"title": "Inception", "description": "Sample description"},
  {"title": "Interstella", "description": "Sample description"},
  {"title": "Joker", "description": "Sample description"},
];

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

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

        title: Text("Exercise 3 - Layout Demo", style: TextStyle(fontSize: 30)),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsetsGeometry.all(15),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(),
          for (int i = 0; i < playingList.length; i++)
            Padding(
              padding: EdgeInsetsGeometry.all(4),
              child: Card(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(7),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text(
                        playingList[i]["title"].substring(0, 1).toUpperCase(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    title: Text(
                      playingList[i]["title"],
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(playingList[i]["description"]),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
