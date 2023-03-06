import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  bool isDaytime = true;
  String location = '';
  String time = '';
  String flag = '';
  String url = '';


  WorldTime({ required this.location, required this.flag, required this.url});


  Future <void> getData() async {
      try {
        Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
        Map ire = jsonDecode(response.body);
        //print(ire);
        //print(ire['title']);
        String datetime = ire['datetime'];
        String offset = ire['utc_offset'];

        DateTime now = DateTime.parse(datetime);
        offset = offset.substring(1,3);
        now = now.add(Duration(hours: int.parse(offset)));

        isDaytime = now.hour > 6 && now.hour < 15? true : false;
        //print(now);
        time = DateFormat.jm().format(now);

      }


      catch (e) {
        print('caught :  $e');
        time = "couldn't get data";
      }
  }
}
