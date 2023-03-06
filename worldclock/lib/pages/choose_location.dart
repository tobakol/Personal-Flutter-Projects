import 'package:flutter/material.dart';
import 'package:worldclock/services/worldtime.dart';
class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index) async {
    WorldTime tester = locations[index];
    await tester.getData();
    Navigator.pop(context, {
      'location' : tester.location,
      'flag' : tester.flag,
      'time' : tester.time,
      'isDaytime' : tester.isDaytime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Choose Location'),
        centerTitle: true,
        elevation: 0,
      ),
      //THe purpose of the appbar here is to automatically create a way to go back to the
      //previous screen with a back button
      body : ListView.builder(
          itemCount: locations.length, //total no of items in the list
          itemBuilder:(context, index){ //uses this to cycle thru the list to build the widget for each
            return Card(

                  child: InkWell(
                    onTap:() {
                      updateTime(index);
                    },
                    highlightColor: Colors.red,
                    splashColor: Colors.amber,
                    child: ListTile(  //tile with image and text as buttons





                        title: Text(locations[index].location),
                        leading: CircleAvatar( //leading is how 2 call images in list tile
                          backgroundImage:AssetImage ('assets/${locations[index].flag}')
                        )


                    ),
                  ),
            );
          }
      ),

    );
  }
}
