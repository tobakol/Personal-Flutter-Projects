import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';

import '../screens/location_screen.dart';
import '../services/weather.dart';


WeatherModel weatherModel = WeatherModel();
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocationData() async {

    var weatherdata = await weatherModel.getWeatherData();


    Navigator.push(context, MaterialPageRoute(builder: (context)
    {return LocationScreen(weatherCond: weatherdata,);}));
    
  }
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

      

  

  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: SpinKitDualRing(
            color: Colors.white,
            size: 150.0,
          )
      ),

    );
  }
}
