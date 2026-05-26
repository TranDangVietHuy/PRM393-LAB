import 'package:flutter/material.dart';

const List<String> movieList = ['Movie A', 'Movie B', 'Movie C', 'Movie D'];
DateTime? date;

class CommonUIDemo extends StatelessWidget {
  const CommonUIDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Exercise 5 - Common UI Demo',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Correct ListView inside Column using Expanded',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            OutlinedButton(
              onPressed: () async {
                date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1800),
                  lastDate: DateTime(2101),
                );
              },
              child: Text("Open Date picker"),
            ),
            if (date != null)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Picked date: $date "),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: movieList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.movie),
                    title: Text(movieList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
