import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

import 'package:weather_app/repo/weather_api.dart';
import 'package:weather_app/repo/weather_repo.dart';
import 'package:weather_app/widget/main_widgets.dart';
import 'package:http/http.dart' as http;



class MainPage extends StatelessWidget {
  MainPage();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _getAppBar(dynamic context) {
    return AppBar(
      title: const Text('Weather'),
      //elevation: 10,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.location_city,
            semanticLabel: 'city',
          ),
          onPressed: () {
            _showCitiesMenu(
                BlocProvider.of<WeatherBloc>(context), context);
          },
        )
      ],
    );
  }

  Widget _getBodyWidget(dynamic state) {
    if (state is StateLoading) return WeatherLoading();
    else if (state is StateError) return WeatherError(error: state.error);
    else if (state is StateLoaded) return WeatherLoaded(city:state.city,weather: state.weather,currentState:state);
    else return null;
  }
  
  _showCitiesMenu(WeatherBloc bloc,dynamic context) async {

    try {
      var cities = await bloc.getCities();

      List<PopupMenuItem<String>> list = [];
      for (int i = 0; i < cities.length - 1; i++) {
        list.add(new PopupMenuItem<String>(
            child: Text(cities[i]["name"]), value: cities[i]["name"]));
      }

      String selected = await showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
              double.infinity, 80.0, 0.0, 40.0),
          items: list);

      if (selected!=null && selected.length > 0) {
        bloc.add(WeatherUpdated(selected, 0));
      }

    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 3)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => WeatherBloc(WeatherRepository(WeatherApiClient(httpClient: new http.Client())))..add(WeatherUpdated("Москва",0)),
        child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return Scaffold(
                  key: _scaffoldKey,
                  appBar: _getAppBar(context),
                  body: Container(
                    padding: EdgeInsets.fromLTRB(10,40,10,40),
                    width: double.infinity,
                      child:_getBodyWidget(state)
                  ),
              );
            }));
  }
}