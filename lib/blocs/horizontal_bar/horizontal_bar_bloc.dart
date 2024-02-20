import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_event.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_state.dart';

class HorizontalBarBloc extends Bloc<HorizontalBarEvent, HorizontalBarState> {
  late int totalWidth;
  HorizontalBarBloc() : super(HorizontalBarInitialState()) {
    on<HorizontalBarInitEvent>((event, emit) {
      totalWidth = event.totalWidth;
    });
    on<HorizontalBarOnValueChangeEvent>((event, emit) {
      if (event.submittedValue > totalWidth) {
        emit(HorizontalBarInvalidValueState("Please enter valid value"));
      } else {
        emit(HorizontalBarValidValueState());
      }
    });
    on<HorizontalBarValueSubmitEvent>((event, emit) {
      emit(HorizontalBarPlotBarState(
          (event.submittedValue * totalWidth / event.totalRange) + 10,
          event.submittedValue));
    });
  }
}
