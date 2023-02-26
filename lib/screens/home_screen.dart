import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/data_models.dart';
import 'package:http/http.dart' as http;

import '../data/models/search_city.dart';

class HomeScreen extends StatefulWidget {
  final String cityName;
  const HomeScreen({super.key, required this.cityName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isloading = true;
  @override
  void initState() {
    super.initState();
    _getData();
    Timer(const Duration(seconds: 5), () {
      debugPrint("Timer ends");
      _isloading = false;
      setState(() {});
    });
  }

  DataModel? dataFromAPI;
  SearchCity? citydatafromapi;
  _getData() async {
    String url =
        "https://geocoding-api.open-meteo.com/v1/search?name=${widget.cityName}";
    http.Response res = await http.get(Uri.parse(url));
    citydatafromapi = SearchCity.fromJson(json.decode(res.body));
    // double latitude = citydatafromapi!.results[0].latitude!;
    // double longitude = citydatafromapi!.results[0].longitude!;
    url =
        "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m";
    res = await http.get(Uri.parse(url));

    dataFromAPI = DataModel.fromJson(json.decode(res.body));

    debugPrint(dataFromAPI?.hourlyUnits!.temperature2m);
    _isloading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityName),
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DateTime temp =
                    DateTime.parse(dataFromAPI!.hourly!.time![index]);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(DateFormat('dd-MM-yyyy  HH:mm a').format(temp)),
                      const Spacer(),
                      Text(dataFromAPI!.hourly!.temperature2m![index]
                          .toString()),
                    ],
                  ),
                );
              },
              itemCount: dataFromAPI!.hourly!.time!.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Button is pressed");
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
