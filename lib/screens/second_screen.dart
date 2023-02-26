import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen({super.key});
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Weather App")),
        body: Column(children: [
          TextField(
            controller: _cityController,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: ((context) =>
              //         const HomeScreen())));
              //// Add functionality for button press here
              Get.to(() => HomeScreen(
                    cityName: _cityController.text,
                  ));
            },
            child: const Text("Check the Weather"),
          )
        ]));
  }
}
