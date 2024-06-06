import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/repository/weather_repository.dart';
import '../modals/weather_modal.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial())
  {
    on<WeatherFetched>( _getCurrentWeather );
  }

  void _getCurrentWeather (
      WeatherFetched event,
      Emitter<WeatherState> emit,
      ) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getCurrentWeather();
      emit(WeatherSuccess(weatherModel: weather));
    }
    catch (e) {

      emit(WeatherFailure(e.toString()));

    }
  }
}
