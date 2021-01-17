import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('⛅', style: TextStyle(fontSize: 64)),
        Text(
          'Загрузка погоды',
          style: theme.textTheme.headline5,
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}

class WeatherError extends StatelessWidget {
  final String error;
  const WeatherError({Key key,this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('🙈', style: TextStyle(fontSize: 64)),
        Text(
          error,
          style: theme.textTheme.headline5,
        ),
      ],
    );
  }
}

Future<void> _handleRefresh(StateLoaded state, dynamic context) async {
  await new Future.delayed(new Duration(seconds: 1));
  BlocProvider.of<WeatherBloc>(context).add(WeatherUpdated(state.city,1));
}

class WeatherLoaded extends StatelessWidget {
  const WeatherLoaded({
    Key key,
    @required this.city,
    @required this.weather,
    @required this.currentState,
  }) : super(key: key);

  final String city;
  final Weather weather;

  final StateLoaded currentState;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => _handleRefresh(currentState, context),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(height: 20),
                  Text(city,
                    style: theme.textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                    ),),
                  const SizedBox(height: 28),
                  Text(weather.formattedCondition,
                    style: theme.textTheme.headline4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),),
                    Text(
                    weather.conditionIcon,
                    style: const TextStyle(fontSize: 100.0),
                    ),
                  const SizedBox(height: 28),
                  Text(
                    weather.formattedTemp,
                    style: theme.textTheme.headline3.copyWith(
                      color:weather.colorTemp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

