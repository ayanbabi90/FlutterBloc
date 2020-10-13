import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/WeatherRepo.dart';

import 'DictResultModel.dart';

class WeatherEvent extends Equatable {

  @override
  List<Object> get props => [];

}

class FetchWeather extends WeatherEvent {
  final String city;

  FetchWeather({ @required this.city }) : assert(city != null);

  @override
  List<Object> get props => [city];

}

class ResethWeather extends WeatherEvent {

}


class WeatherState extends Equatable {

  @override
  List<Object> get props => [];

}

class WeatherIsNotSearched extends WeatherState {

}

class WeatherIsLoading extends WeatherState {

}

class WeatherIsLoaded extends WeatherState {
  final DictResult dictResult;

  WeatherIsLoaded({ @required this.dictResult}): assert(dictResult != null);

  @override
  List<Object> get props => [dictResult];

}

class WeatherIsNotLoaded extends WeatherState {
  final String error;

  WeatherIsNotLoaded({ @required this.error }) : assert( error != null);

  @override
  List<Object> get props => [error];
}

class WeatherBloc extends Bloc<WeatherEvent,WeatherState> {

  final WeatherRepo apiRepo;

  WeatherBloc({ @required this.apiRepo }) : assert( apiRepo != null), super(WeatherIsNotSearched());


  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // TODO: implement mapEventToState
    if(event is FetchWeather){
      print("event: " + event.toString());
      yield WeatherIsLoading();
      try {
        final DictResult dictResult = await apiRepo.getWeatherReport(event.city);
        yield WeatherIsLoaded(dictResult: dictResult);
      }catch(e) {
        yield WeatherIsNotLoaded(error: e.toString());
      }
    }else if (event is ResethWeather){
      yield WeatherIsNotSearched();
    }

  }

}