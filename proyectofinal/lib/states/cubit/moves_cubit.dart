import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/states/moves_state.dart';

class MovesCubit extends Cubit<MovesState> {
  MovesCubit() : super(MovesInitial());

  final dio = Dio();

  void fetch() async {}
}
