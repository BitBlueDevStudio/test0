import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/repo/weather_repo.dart';

abstract class WeatherEvent extends Equatable {

}

abstract class WeatherState extends Equatable {

}

class WeatherUpdated extends WeatherEvent  {

  final String query;
  final int type;
  WeatherUpdated(this.query,this.type);

  @override
  List<Object> get props => [query];

}

class StateInitial extends WeatherState {

  StateInitial();

  @override
  List<Object> get props => [];

}

class StateLoading extends WeatherState {

  @override
  List<Object> get props => [];
}

class StateLoaded extends WeatherState {
  final String city;
  final Weather weather;

  StateLoaded(this.city,
      this.weather
      );

  @override
  List<Object> get props => [city,
    weather
  ];
}

class StateError extends WeatherState {

  final String error;

  StateError(this.error);

  @override
  List<Object> get props => [error];
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepository repo;
  WeatherBloc(this.repo) : super(StateLoading());

  getCities() async {
    return await repo.getCitiesForQuery("ALL");
  }


  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherUpdated) {
      if (event.type==0) yield StateLoading();
      try {
        final vs = await repo.getWeatherForCity(event.query);
        yield StateLoaded(event.query, Weather.fromJson(vs));
      } catch (Exception){
        if (Exception.toString().contains("Unknown city")) yield StateError("Ошибка: город не найден");
        else yield StateError(Exception.toString());
      }
    }
  }

}