
import 'package:worldclock/services/worldtime.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void getWorldTime() async{
    WorldTime tester = WorldTime( location : 'London', flag: 'door.png' , url: 'Europe/Berlin' );
    await tester.getData();
    Navigator.pushReplacementNamed(context, '/home', arguments : {
      'location' : tester.location,
      'flag' : tester.flag,
      'time' : tester.time,
      'isDaytime' : tester.isDaytime

    });
  }
  @override
  void initState() {
    super.initState();
    getWorldTime();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[900],
      body: Center(
          child: SpinKitChasingDots(
            color: Colors.white,
            size: 150.0,
          )
      ),

    );
  }
}
