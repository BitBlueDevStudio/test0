import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Weather extends Equatable {
  final String conditionIcon ;
  final String formattedCondition;
  final double temp;
  final String formattedTemp;
  final Color colorTemp;

  const Weather({
    this.conditionIcon,
    this.formattedCondition,
    this.temp,
    this.formattedTemp,
    this.colorTemp
  });

  static String _mapConditionTranslateRus(String input) {
    String state;
    switch (input) {
      case 'Snow':
        state = "Снег";
        break;
      case 'Thunderstorm':
        state = "Гроза";
        break;
      case 'Rain':
        state = "Дождь";
        break;
      case 'Clouds':
        state = "Облачно";
        break;
      case 'Clear':
        state = "Чисто";
        break;
      case 'Mist':
        state = "Туман";
        break;
      case 'Smoke':
        state = "Дым";
        break;
      case 'Haze':
        state = "Мгла";
        break;
      case 'Dust':
        state = "Пыль";
        break;
      case 'Squall':
        state = "Шквал";
        break;
      case 'Ash':
        state = "Пепел";
        break;
      case 'Fog':
        state = "Туман";
        break;
      case 'Sand':
        state = "Песочно";
        break;
      case 'Tornado':
        state = "Торнадо";
        break;
      default:
        state = "Неизвестно";
    }
    return state;
  }

  static String _mapConditionToIcon(String input) {
    String state;
    switch (input) {
      case 'Snow':
        state = '🌨️';
        break;
      case 'Thunderstorm':
        state = '🌧️';
        break;
      case 'Rain':
        state = '🌧️';
        break;
      case 'Clouds':
        state = '☁️';
        break;
      case 'Clear':
        state ='☀️';
        break;
      case 'Mist':
        state = '🌫️';
        break;
      case 'Smoke':
        state = '🌫️';
        break;
      case 'Haze':
        state = '⬛';
        break;
      case 'Dust':
        state = '☀️';
        break;
      case 'Squall':
        state = '🌨️';
        break;
      case 'Ash':
        state = '🌫️';
        break;
      case 'Fog':
        state = '🌫️';
        break;
      case 'Sand':
        state = '☀️';
        break;
      case 'Tornado':
        state = '🌪️️';
        break;
      default:
        state = '❓';
    }
    return state;
  }

  static String _tempToText(String input) {
    return input+" °C";
  }

  static Color _tempToColor(double temp) {
    if (temp>0) return Colors.red;
    else return Colors.blue;
  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }

  static Weather fromJson(dynamic json) {
    return Weather(
      conditionIcon: _mapConditionToIcon(
          json["weather"][0]["main"]),
      formattedCondition: _mapConditionTranslateRus(json["weather"][0]["main"]),
      temp: checkDouble(json["main"]["temp"]),
      colorTemp: _tempToColor(checkDouble(json["main"]["temp"])),
      formattedTemp: _tempToText(json["main"]["temp"].toString())
    );
  }

  @override
  List<Object> get props =>
      [
        conditionIcon,
        formattedCondition,
        temp,
        formattedTemp,
        colorTemp
      ];

}