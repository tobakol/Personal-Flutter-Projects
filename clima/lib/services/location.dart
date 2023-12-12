import 'package:geolocator/geolocator.dart';
class Location{
  var latitude;
  var longitude;

  Location({this.latitude, this.longitude});

  void getCurrentPosition()async{
    try {
      Position position = await GeolocatorPlatform.instance.getCurrentPosition();
      longitude = position.longitude;
      latitude = position.latitude;
    }
    catch(e){
      print(e);

    }
  }
}