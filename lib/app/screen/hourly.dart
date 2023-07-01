import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tap_to_expand/tap_to_expand.dart';
//import 'package:intl/intl.dart';

import '../controller/constant.dart';
import '../core/WeatherItem.dart';

class hourly extends StatefulWidget {
  final dailyForecastWeather1;
  final locationData2;

  const hourly(
      {Key? key, this.dailyForecastWeather1, required this.locationData2})
      : super(key: key);

  @override
  State<hourly> createState() => _hourlyState();
}

class _hourlyState extends State<hourly> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather1;
    var weatherData2 = widget.locationData2;
    String currentTime = DateFormat().format(DateTime.now());
    // String currentHour = currentTime.substring(0, 2);
 

        
    //function to get hourly
    Map hourlyWeatherForecast(int index) {
      String location = weatherData2["name"];
      // int WindSpeed = weatherData[index]["hour"]["wind_mph"].toInt();
      int Humidity = weatherData[index]["humidity"];
      int dewpoint = weatherData[index]["dewpoint_c"].toInt();
      int chanceofrain = weatherData[index]["chance_of_rain"];
      int windspeed = weatherData[index]["wind_kph"].toInt();
      // int maxtemp = weatherData[index]["humidity"];
      // int mintemp = weatherData[index]["humidity"];

      String time = weatherData[index]["time"];
     
                                  
      var forecastData = {
        'location': location,
        'time': time,

        'Humidity': Humidity,
        'dewpoint': dewpoint,
        'chanceofrain': chanceofrain,
        'windspeed': windspeed,
        // 'maxtemp':maxtemp,
        // 'mintemp':mintemp,
      };
      return forecastData;
    }

    return Scaffold(
        backgroundColor: _constants.primaryColor,
        appBar: AppBar(
          title: const Text('Hourly'),
          centerTitle: true,
          backgroundColor: _constants.primaryColor,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: size.height * .3,
                decoration: BoxDecoration(
                  gradient: _constants.linearGradientBlue,
                  boxShadow: [
                    BoxShadow(
                      color: _constants.primaryColor.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                                  const SizedBox(width: 2,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Time:",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            // const SizedBox(
                            //   width: 2,
                            // ),
                            Text(
                              currentTime,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                          ],
                        ),
                        const SizedBox(width: 8,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/pin.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              hourlyWeatherForecast(0)["location"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Text(
                    //   currentWeatherStatus,
                    //   style: const TextStyle(
                    //     color: Colors.white70,
                    //     fontSize: 20.0,
                    //   ),
                    // ),
                    // Text(
                    //   currentDate,
                    //   style: const TextStyle(
                    //     color: Colors.white70,
                    //   ),
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: const Divider(
                    //     color: Colors.white70,
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherItem(
                            value: hourlyWeatherForecast(0)["windspeed"],
                            unit: "km/h",
                            imageUrl: "assets/windspeed.png",
                          ),
                          WeatherItem(
                            value: hourlyWeatherForecast(0)["Humidity"],
                            unit: "%",
                            imageUrl: "assets/humidity.png",
                          ),
                          WeatherItem(
                            value: hourlyWeatherForecast(0)["chanceofrain"],
                            unit: "%",
                            imageUrl: "assets/lightrain.png",
                          ),
                          WeatherItem(
                            value: hourlyWeatherForecast(0)["dewpoint"],
                            unit: "%",
                            imageUrl: "assets/dewpoint.png",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: TapToExpand(
                  content: Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Image.asset(
                            'assets/windspeed.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(1)["windspeed"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/humidity.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(1)["Humidity"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/lightrain.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(1)["chanceofrain"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/dewpoint.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(1)["dewpoint"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  title: Text(
                    hourlyWeatherForecast(1)["time"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onTapPadding: 20,
                  closedHeight: 70,
                  scrollable: true,
                  borderRadius: 20,
                  openedHeight: 200,
                ),
              ),
              Center(
                child: TapToExpand(
                  content: Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Image.asset(
                            'assets/windspeed.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(2)["windspeed"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/humidity.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(2)["Humidity"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/lightrain.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(2)["chanceofrain"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/dewpoint.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(2)["dewpoint"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  title: Text(
                    hourlyWeatherForecast(2)["time"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onTapPadding: 20,
                  closedHeight: 70,
                  scrollable: true,
                  borderRadius: 20,
                  openedHeight: 200,
                ),
              ),
              Center(
                child: TapToExpand(
                  content: Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Image.asset(
                            'assets/windspeed.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(3)["windspeed"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/humidity.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(3)["Humidity"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/lightrain.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(3)["chanceofrain"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/dewpoint.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(3)["dewpoint"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  title: Text(
                    hourlyWeatherForecast(3)["time"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onTapPadding: 20,
                  closedHeight: 70,
                  scrollable: true,
                  borderRadius: 20,
                  openedHeight: 200,
                ),
              ),
              Center(
                child: TapToExpand(
                  content: Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Image.asset(
                            'assets/windspeed.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(4)["windspeed"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/humidity.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(4)["Humidity"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/lightrain.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(4)["chanceofrain"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/dewpoint.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(4)["dewpoint"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  title: Text(
                    hourlyWeatherForecast(4)["time"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onTapPadding: 20,
                  closedHeight: 70,
                  scrollable: true,
                  borderRadius: 20,
                  openedHeight: 200,
                ),
              ),
              Center(
                child: TapToExpand(
                  content: Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Image.asset(
                            'assets/windspeed.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(5)["windspeed"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/humidity.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(5)["Humidity"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/lightrain.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(5)["chanceofrain"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/dewpoint.png',
                            width: 30,
                          ),
                          Text(
                            hourlyWeatherForecast(5)["dewpoint"].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  title: Text(
                    hourlyWeatherForecast(5)["time"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onTapPadding: 20,
                  closedHeight: 70,
                  scrollable: true,
                  borderRadius: 20,
                  openedHeight: 200,
                ),
              ),
            ],
          ),
        )
        // : Container(),
        );
  }
}
