import 'dart:convert';
import 'dart:ui';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/app/controller/constant.dart';
import 'package:weather_app/app/screen/DetailPage.dart';
import 'package:weather_app/app/screen/hourly.dart';
import '../core/WeatherItem.dart';

class display extends StatefulWidget {
  const display({super.key});

  @override
  State<display> createState() => _displayState();
}

class _displayState extends State<display> {
  final TextEditingController _citycontroller = TextEditingController();
  final _constants = Constants();

  String location = "India";
  String weathericon = 'heavycloudy.png';
  int temperature = 0;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  int uv = 0;
  int pressure_mb = 0;
int dewpoint= 0;
  int maxtemp = 0;
  int mintemp = 0;
 // int dewpoint = 0;
  String? _searchText;

  String currentDate = '';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentWeatherStatus = '';

  get weatherData => null;
  var locationData ;

//  geoLocation
  // Position? _currentLocation;
  // late bool servicePermission = false;
  // late LocationPermission permission;
  // String _currentAdress = "";
  // Future<Position>_getCurrentLocation() async{
  //   servicePermission = await Geolocator.isLocationServiceEnabled();
  //    if (!servicePermission) {
  //     print("service disabled");

  //    }
  //      permission = await Geolocator.checkPermission();

  //       if (permission == LocationPermission.denied) {
  //         permission = await Geolocator.requestPermission();
  //       }

  //    return await Geolocator.getCurrentPosition();

  // }
  // _getAddressFromCoordinates() async{
  //   try{
  //     List<Placemark> Placemarks = await placemarkFromCoordinates(_currentLocation!.latitude, _currentLocation!.longitude);
  //     Placemark place = Placemarks[0];
  //     setState(() {
  //       _currentAdress = "${place.locality},${place.country}";
  //     });
  //   }catch(e){
  //     print(e);
  //   }

  // }

  void fetchWeatherData(String searchText) async {
    setState(() {
      _searchText=searchText;
    });
 try {
      var searchResult = await http.get(Uri.parse(
          "https://api.weatherapi.com/v1/forecast.json?key= 626daf9a78424411a62115730233006 &q=$searchText&days=10&aqi=no&alerts=no"));

      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No data');

       locationData = weatherData["location"];

      var currentWeather = weatherData["current"];

      setState(() {
        location = getShortLocationName(locationData["name"]);

        var parsedDate =
            DateTime.parse(locationData["localtime"].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
        currentDate = newDate;

        //updateWeather
        currentWeatherStatus = currentWeather["condition"]["text"];
        weathericon = currentWeatherStatus.replaceAll(' ', '').toLowerCase() + ".png";
        temperature = currentWeather["temp_c"].toInt();
        windSpeed = currentWeather["wind_kph"].toInt();
        humidity = currentWeather["humidity"].toInt();
        cloud = currentWeather["cloud"].toInt();
        uv = currentWeather["uv"].toInt();
        pressure_mb = currentWeather["pressure_mb"].toInt();

        //Forecast data
        dailyWeatherForecast = weatherData["forecast"]["forecastday"];
        hourlyWeatherForecast = dailyWeatherForecast[0]["hour"];
        maxtemp = dailyWeatherForecast[0]["day"]["maxtemp_c"].toInt();
        mintemp = dailyWeatherForecast[0]["day"]["mintemp_c"].toInt();
       dewpoint = dailyWeatherForecast[0]["hour"][0]["dewpoint_c"].toInt();                          
      });
    } catch (e) {
      //debugPrint(e);
    }
  }

  //function to return the first two names of the string location
  static String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return wordList[0] + " " + wordList[1];
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }

  void onTextFieldSubmitted(String input) async {
    fetchWeatherData(input);
  }

  @override
  void initState() {
    fetchWeatherData(location);
    super.initState();
  }

  //refresh
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SmartRefresher(
        onRefresh: onRefresh,
        controller: refreshController,
        enablePullDown: true,
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
          color: _constants.primaryColor.withOpacity(.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: size.height * .7,
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
                    //   Text(
                    //     'Location Coordinates ',
                    //     style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    // SizedBox(height: 10,),
                    // Text("Latitude = ${_currentLocation?.latitude}; Longitude = ${_currentLocation?.longitude}",
                    // style: TextStyle(color: Colors.black,fontSize: 16),),
                    // SizedBox(height: 10,),
                    // Text('Location ADDRESS',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    // SizedBox(height: 10,),
                    //  Text( "${_currentAdress}"),
                    // ElevatedButton(onPressed: () async{

                    //     _currentLocation = await _getCurrentLocation();
                    //   await _getAddressFromCoordinates();
                    //   print("${_currentLocation}");
                    //           print("${_currentAdress}");

                    // }, child: Text('Get Location')),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // GestureDetector(
                            //   onTap: (){location;},
                            //   child: Icon(Icons.location_city,size: 36.0,color: Colors.white,),
                            // ),
                            Image.asset(
                              "assets/pin.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                        
     

                            AnimSearchBar(
                              width: 250,
                              onSubmitted: (searchText) {
                                fetchWeatherData(searchText);
                              },
                              onSuffixTap: null,
                              textController: _citycontroller,
                              
                              helpText: "Location search",
                              textFieldColor: Colors.blue[50],
                              searchIconColor: Colors.white,
                              color: Colors.blue[400],
                              autoFocus: true,
                              closeSearchOnSuffixTap: false,
                              animationDurationInMilli: 1500,
                            ),

                           
                          ],
                        ),
                    
                      ],
                    ),

                    SizedBox(
                      height: 145,
                      child: Image.asset("assets/" + weathericon),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            temperature.toString(),
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = _constants.shader,
                            ),
                          ),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = _constants.shader,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      currentWeatherStatus,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      currentDate,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Divider(
                        color: Colors.white70,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherItem(
                            value: uv.toInt(),
                            unit: '',
                            imageUrl: 'assets/sunny.png',
                          ),
                          WeatherItem(
                            value: pressure_mb.toInt(),
                            unit: '%',
                            imageUrl: 'assets/pressure.png',
                          ),
                           WeatherItem(
                            value: dewpoint.toInt(),
                            unit: '%',
                            imageUrl: 'assets/dewpoint.png',
                          ),
                           
                               
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherItem(
                            value: windSpeed.toInt(),
                            unit: 'km/h',
                            imageUrl: 'assets/windspeed.png',
                          ),
                          WeatherItem(
                            value: humidity.toInt(),
                            unit: '%',
                            imageUrl: 'assets/humidity.png',
                          ),
                          WeatherItem(
                            value: maxtemp.toInt(),
                            unit: 'o',
                            imageUrl: 'assets/high.png',
                          ),
                          WeatherItem(
                            value: mintemp.toInt(),
                            unit: 'o',
                            imageUrl: 'assets/fog.png',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                height: size.height * .20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DetailPage(
                                        dailyForecastWeather:
                                            dailyWeatherForecast,
                                      ))), //this will open forecast screen
                          child: Text(
                            'Forecasts',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: _constants.primaryColor,
                            ),
                          ),
                        ),
                         GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => hourly(
                                        dailyForecastWeather1:
                                          hourlyWeatherForecast, 
                                          locationData2: locationData,
                                      ))), //this will open hourly screen
                          child: Text(
                            'Hourly',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: _constants.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        itemCount: hourlyWeatherForecast.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                           String currentTime =
                               DateFormat('HH:mm:ss').format(DateTime.now());
                           String currentHour = currentTime.substring(0, 2);

                          String forecastTime = hourlyWeatherForecast[index]
                                  ["time"]
                              .substring(11, 16);
                          String forecastHour = hourlyWeatherForecast[index]
                                  ["time"]
                              .substring(11, 13);

                          String forecastWeatherName =
                              hourlyWeatherForecast[index]["condition"]["text"];
                          String forecastWeatherIcon = forecastWeatherName
                                  .replaceAll(' ', '')
                                  .toLowerCase() +
                              ".png";

                          String forecastTemperature =
                              hourlyWeatherForecast[index]["temp_c"]
                                  .round()
                                  .toString();
                                 
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            margin: const EdgeInsets.only(right: 20),
                            width: 65,
                            decoration: BoxDecoration(
                               color: currentHour == forecastHour
                                    ? Colors.blue
                                    : _constants.primaryColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 5,
                                    color:
                                        _constants.primaryColor.withOpacity(.2),
                                  ),
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  forecastTime,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: _constants.greyColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Image.asset(
                                  'assets/' + forecastWeatherIcon,
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      forecastTemperature,
                                      style: TextStyle(
                                        color: _constants.greyColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'o',
                                      style: TextStyle(
                                        color: _constants.greyColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        fontFeatures: const [
                                          FontFeature.enable('sups'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onRefresh() async {
     try {
      var searchResult = await http.get(Uri.parse(_searchText!=null?
          "https://api.weatherapi.com/v1/forecast.json?key= 626daf9a78424411a62115730233006 &q=$_searchText&days=10&aqi=no&alerts=no":
          "https://api.weatherapi.com/v1/forecast.json?key= 626daf9a78424411a62115730233006 &q=madurai&days=10&aqi=no&alerts=no"));

      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No data');

      var locationData = weatherData["location"];

      var currentWeather = weatherData["current"];

      setState(() {
        location = getShortLocationName(locationData["name"]);

        var parsedDate =
            DateTime.parse(locationData["localtime"].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
        currentDate = newDate;

        //updateWeather
        currentWeatherStatus = currentWeather["condition"]["text"];
        weathericon =
            currentWeatherStatus.replaceAll(' ', '').toLowerCase() + ".png";
        temperature = currentWeather["temp_c"].toInt();
        windSpeed = currentWeather["wind_kph"].toInt();
        humidity = currentWeather["humidity"].toInt();
        cloud = currentWeather["cloud"].toInt();
        uv = currentWeather["uv"].toInt();
        pressure_mb = currentWeather["pressure_mb"].toInt();

        //Forecast data

        dailyWeatherForecast = weatherData["forecast"]["forecastday"];
        hourlyWeatherForecast = dailyWeatherForecast[0]["hour"];
        maxtemp = dailyWeatherForecast[0]["day"]["maxtemp_c"].toInt();
        mintemp = dailyWeatherForecast[0]["day"]["mintemp_c"].toInt();
        dewpoint = dailyWeatherForecast[0]["hour"][0]["dewpoint_c"].toInt();
      });
    } catch (e) {
      //debugPrint(e);
    }
    await Future.delayed(const Duration(seconds: 1));
    refreshController.refreshCompleted();
    setState(() {});
  }
}
