import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_event.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_state.dart';

class HorizontalBarBloc extends Bloc<HorizontalBarEvent, HorizontalBarState> {
  HorizontalBarBloc() : super(HorizontalBarInitialState()) {
    on<HorizontalBarOnValueChangeEvent>((event, emit) {
      if (event.submittedValue < 0 ||
          (event.submittedValue * event.totalWidth / event.totalRange) >
              event.totalWidth) {
        emit(HorizontalBarInvalidValueState("Please enter valid value"));
      } else {
        emit(HorizontalBarValidValueState());
      }
    });
    on<HorizontalBarValueSubmitEvent>((event, emit) {
      emit(HorizontalBarPlotBarState(
          (event.submittedValue * event.totalWidth / event.totalRange) + 7,
          event.submittedValue,
          true));
    });
  }
}
