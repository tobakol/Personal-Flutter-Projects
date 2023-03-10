import '../services/networking.dart';
import '../services/location.dart';

const api_key =
    'api-key'; //register at https://api.openweathermap.org to get a valid api-key
const apiSource = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getanyWeatherData(cityName) async {
    NetworkHelper networkHelper =
        NetworkHelper('$apiSource?q=$cityName&units=metric&appid=$api_key');
    var weatherdata = await networkHelper.getData();
    return weatherdata;
  }

  Future<dynamic> getWeatherData() async {
    Location location = Location();

    await location.getCurrentPosition();
    print(location.longitude);
    print(location.latitude);

    NetworkHelper networkHelper = NetworkHelper(
        '$apiSource?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$api_key');
    var weatherdata = await networkHelper.getData();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
