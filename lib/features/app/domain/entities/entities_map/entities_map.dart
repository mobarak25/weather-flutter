import 'package:weather/features/app/domain/entities/default_response.dart';
import 'package:weather/features/app/domain/entities/login.dart';
import 'package:weather/features/app/domain/entities/weather.dart';

class EntityMap {
  static T? mapModal<T, K>(dynamic josnData) {
    switch (T) {
      case DefaultResponse:
        return DefaultResponse.fromJson(josnData) as T;
      case Weather:
        return Weather.fromJson(josnData) as T;
      case Login:
        return Login.fromJson(josnData) as T;

      default:
        throw Exception('Unknown class');
    }
  }
}
