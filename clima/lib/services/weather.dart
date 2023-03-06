import '../services/networking.dart';
import '../services/location.dart';

const api_key = 'e9a336dc55698488726dc979913c8ead';
const apiSource= 'https://api.openweathermap.org/data/2.5/weather';


class WeatherModel {
  Future <dynamic> getanyWeatherData(cityName)async{
    NetworkHelper networkHelper = NetworkHelper('$apiSource?q=$cityName&units=metric&appid=$api_key');
    var weatherdata = await networkHelper.getData();
    return weatherdata;
  }

  Future <dynamic> getWeatherData()async{
    Location location = Location();

    await location.getCurrentPosition();
    print(location.longitude);
    print(location.latitude);

    NetworkHelper networkHelper = NetworkHelper('$apiSource?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$api_key');
    var weatherdata = await networkHelper.getData();
    return weatherdata;

  }


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
