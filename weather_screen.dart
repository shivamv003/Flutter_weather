import 'dart:convert';

import 'package:flutter/material.dart';
import 'weather_forcast_hourly.dart';
import 'package:intl/intl.dart';
import 'additional_info.dart';
import 'secret.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // double temp =0;
  @override
  void initState() {
    fetchWeather();
    super.initState();
    weather = fetchWeather();
  }

  late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>> fetchWeather() async {
    try {
      const String city = 'India';
      const String url =
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$apiKey';
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      if (response.statusCode != 200) {
        throw 'An unexpected error occured';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }
  // Future getCurrentWeather() async {
  //   String cityName = 'London';
  //   final res = await http.get(
  //     Uri.parse(
  //         'https://http://api.openweathermap.org/data/2.5/weather?q=$cityName,uk&APPID=d3b18188f95e78c3f5a682a0375a703e'),
  //   );
  //   print(res.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          // print(snapshot.runtimeType);
          final data = snapshot.data!;

          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentHumidity = data['list'][0]['main']['humidity'];
          // list[0].wind.speed
          final currentSpeed = data['list'][0]['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: Column(
                      children: [
                        Text(
                          '$currentTemp k',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 50,
                          ),
                        ),
                        Icon(
                          currentSky == 'Clouds' || currentSky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                          size: 95,
                        ),
                        Text(
                          '$currentSky',
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Hourley Forcast',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 5; i++)
                //         HourlyFourcastItem(
                //           time: data['list'][i + 1]['dt'].toString(),
                //           // time: '255',
                //           icon: data['list'][i + 1]['weather'][0]['main'] ==
                //                       'Clouds' ||
                //                   data['list'][i + 1]['weather'][0]['main'] ==
                //                       'Rain'
                //               ? Icons.cloud
                //               : Icons.sunny,
                //           // icon: Icons.water_drop,

                //           temperature:
                //               data['list'][i + 1]['main']['temp'].toString(),
                //         ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final HourlyFourcast = data['list'][index + 1];
                      final HourleySky =
                          data['list'][index + 1]['weather'][0]['main'];
                      final HourleyTemp =
                          HourlyFourcast['main']['temp'].toString();
                      final time = DateTime.parse(HourlyFourcast['dt_txt']);

                      return HourlyFourcastItem(
                        time: DateFormat.j().format(time),
                        temperature: HourleyTemp,
                        icon: HourleySky == 'Clouds' || HourleySky == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                      );
                    },
                  ),
                ),

                // },
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Aditional Information',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Additionalinfoitem(
                      icon: Icons.water_drop,
                      label: 'humidity',
                      value: currentHumidity.toString(),
                    ),
                    Additionalinfoitem(
                      icon: Icons.wind_power_outlined,
                      label: 'Wind Speed',
                      value: currentSpeed.toString(),
                    ),
                    Additionalinfoitem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      // value: '$currentPressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ctrl + shift + R to make a widget 