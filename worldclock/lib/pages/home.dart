import 'package:flutter/material.dart';
import 'dart:core';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    String bgImage = data['isDaytime'] ? 'day.jpg' : 'night.PNG';
    Color? bgColor =
        data['isDaytime'] ? Colors.blue[800] : Colors.blueGrey[900];
    print(data);

    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(children: [
                GestureDetector(
                  onTap: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    //This enables us push another screen on top of the current one
                    // usually written as Navigator.pushNamed(context, 'map key');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'flag': result['flag'],
                        'time': result['time'],
                        'isDaytime': result['isDaytime']
                      };
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: Row(
                      children: const [
                        Icon(Icons.edit_location),
                        Text('Edit Location'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.red),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  data['time'],
                  style: TextStyle(
                      fontSize: 80.0, letterSpacing: 2.0, color: Colors.red),
                )
              ]),
            ),
          ),
        ));
  }
}
