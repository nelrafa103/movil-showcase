abstract class AppState {}

class AppInitial extends AppState {}

class AppLoaded extends AppState {
  int index;
  AppLoaded({required this.index});
}
