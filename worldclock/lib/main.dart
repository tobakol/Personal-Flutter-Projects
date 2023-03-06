import 'package:flutter/material.dart';
import 'package:worldclock/pages/choose_location.dart';
import 'package:worldclock/pages/home.dart';
import 'package:worldclock/pages/loading.dart';


void main() {
  runApp( MaterialApp(
    // home:Home(), commented  out to prevent conflict with 'routes'
    initialRoute: '/',
    //assigns default screen
    routes: {
      '/': (context) => Loading(),
      '/home' : (context) => Home(),
      '/location': (context) =>ChooseLocation(),


      //location: function =>widget/class
    },

    // routes uses maps(dictionaries in python).
    // It's what enables movement between multiple screens

  ));
}

