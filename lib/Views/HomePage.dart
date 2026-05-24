import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Text('data'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),

        ],
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blueAccent),
          ),
          child: Center(
            child: Image.asset(
              'assets/images/img1.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    bottomNavigationBar: Container(
      color: Colors.blueGrey[900],
      padding: const EdgeInsets.all(16.0),
      child: const Text(
        '© 2026 All rights reserved.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      )
    ),
    );
  }
}