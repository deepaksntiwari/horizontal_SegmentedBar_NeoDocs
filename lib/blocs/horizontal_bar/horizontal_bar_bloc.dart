import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_event.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_state.dart';

class HorizontalBarBloc extends Bloc<HorizontalBarEvent, HorizontalBarState> {
  HorizontalBarBloc() : super(HorizontalBarInitialState());

}
