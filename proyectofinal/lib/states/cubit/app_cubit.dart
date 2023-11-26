import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/states/app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  void changeTab(int index) {
    emit(AppLoaded(index: index));
  }
}
