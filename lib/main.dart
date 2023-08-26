import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openweather_app/consts/image_handler.dart';
import 'package:flutter_openweather_app/controller/controller.dart';
import 'package:flutter_openweather_app/data/weather_api_client.dart';
import 'package:flutter_openweather_app/models/forecast_model.dart';
import 'package:flutter_openweather_app/models/weather_model.dart';
import 'package:flutter_openweather_app/widgets/current_weather_widget.dart';
import 'package:flutter_openweather_app/widgets/hour_forecast_widget.dart';
import 'package:flutter_openweather_app/widgets/search_city_widget.dart';
import 'package:flutter_openweather_app/widgets/today_widget.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff081b25),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller = Get.put(StateController());
  var location = Location();
  late StreamSubscription listener;
  late PermissionStatus _permissionStatus;

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) async {
      await enableLocationListener();
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    var dateFormat = DateFormat('EEEE, d MMM yyyy').format(date);
    String time = DateFormat('HH:mm').format(date);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Obx(
      () => Container(
        child: controller.position.value != null
            ? FutureBuilder(
                future: WeatherApiClient()
                    .getWeatherByLocation(controller.position.value),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text(
                        'No data',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    var data = snapshot.data as WeatherResponse;
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SearchCityWidget(
                            width: size.width * 0.90,
                            height: size.height * 0.07,
                            searchController: TextEditingController(),
                            onTap: () {},
                          ),
                          CurrentWeatherWidget(
                            size: size,
                            temp: //con grados celsius
                                '${data.main!.temp!.round()}°',
                            description: '${data.weather![0].description}',
                            image: imageHandler((data.id!.toInt()), time),
                            cityName:
                                (data.name != null && data.name!.isNotEmpty)
                                    ? data.name!
                                    : '${data.coord!.lat}, ${data.coord!.lon}',
                            country: data.sys!.country!.toString(),
                            date: dateFormat,
                            humidity: '${data.main!.humidity}%',
                            speed: '${data.wind!.speed} km/h}',
                            windDirection: '${data.wind!.deg}°',
                          ),
                          TodayWidget(),
                          Expanded(
                              child: FutureBuilder(
                            future: WeatherApiClient().getForecastByLocation(
                                controller.position.value),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    snapshot.error.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              } else if (!snapshot.hasData) {
                                return const Center(
                                  child: Text(
                                    'No data',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              } else {
                                var data = snapshot.data as ForecastResponse;
                                return ListView.builder(
                                  itemCount: data.list!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var item = data.list![index];
                                    return HourForecastWidget(
                                        image: imageHandler(800, time),
                                        time: DateFormat('HH:mm').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                (item.dt ?? 0) * 1000)),
                                        forecastTemp: '${item.main!.temp}°C');
                                  },
                                );
                              }
                            },
                          ))
                        ]);
                  }
                })
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    ));
  }

  Future<void> enableLocationListener() async {
    controller.locationIsEnabled.value = await location.serviceEnabled();
    if (!controller.locationIsEnabled.value) {
      controller.locationIsEnabled.value = await location.requestService();
      if (!controller.locationIsEnabled.value) {
        Get.snackbar('Error', 'Location is not enabled');
        return;
      }
    }

    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        Get.snackbar('Error', 'Location permission is not granted');
        return;
      }
    }

    controller.position.value = await location.getLocation();
    listener = location.onLocationChanged.listen((event) {});
  }
}
