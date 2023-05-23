import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather.dart';

class DataService {
  Future<Weather> fetchData(String cityName) async {
    try {
      // https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
      final queryParameters = {
        'q': cityName,
        'appid': '537618b4cb87417f94f1b5b70fcd2166',
        'units': 'imperial'
      };
      final uri = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', queryParameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('failed to load weather');
      }
    } catch (e) {
      rethrow;
    }
  }
}
