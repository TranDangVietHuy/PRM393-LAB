import 'package:flutter/material.dart';

enum Genre { action, comedy }

class InputControl extends StatefulWidget {
  const InputControl({super.key});

  @override
  State<InputControl> createState() => _InputControlState();
}

class _InputControlState extends State<InputControl> {
  double sliderValue = 0;
  bool swichState = false;
  String? genre;

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
          "Exercise 2 - Input Control Demo",
          style: TextStyle(fontSize: 30),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(2),
          child: Column(
            spacing: 25,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 7,
                children: [
                  Text(
                    "Rating (Slider)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 20.0, end: 20),
                    child: Slider(
                      value: sliderValue,
                      onChanged: (double v) {
                        setState(() {
                          sliderValue = v;
                        });
                      },
                      min: 0,
                      max: 100,
                      divisions: 100,
                    ),
                  ),
                  Text(
                    "Current value: ${sliderValue.toStringAsFixed(0)}",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Column(
                spacing: 7,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Active (Switch)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 25.0, end: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          "Is movie active?",
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Switch(
                          value: swichState,
                          onChanged: (state) {
                            setState(() {
                              swichState = state;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 7,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Genre (RadioListTitle)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),

                  RadioGroup(
                    groupValue: genre,
                    onChanged: (String? value) {
                      setState(() {
                        genre = value;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioListTile(title: Text("Action"), value: "Action"),
                        RadioListTile(title: Text("Comedy"), value: "Comedy"),
                      ],
                    ),
                  ),
                  Text(
                    "Selected genre: ${genre ?? "None"}",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 247, 247, 247),

                    side: BorderSide.none,
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text("Open Date Picker"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
