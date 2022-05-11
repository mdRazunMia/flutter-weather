import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WeatherApiClient {
  //Future<Weather> getCurrentWeather(String? location)
  Future getCurrentWeather(String? location) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=9ce51d70746821cd2fee4ddab5a7267b&units=metric");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);
      Weather weather = Weather.fromJson(body);
      return weather;
    }
    return null;
  }
}
