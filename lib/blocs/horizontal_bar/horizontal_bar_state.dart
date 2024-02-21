abstract class HorizontalBarState {}

class HorizontalBarInitialState extends HorizontalBarState {}

class HorizontalBarValidValueState extends HorizontalBarState {}

class HorizontalBarInvalidValueState extends HorizontalBarState {
  final String errorMsg;
  HorizontalBarInvalidValueState(this.errorMsg);
}

class HorizontalBarPlotBarState extends HorizontalBarState {
  final double pointerPosition;
  final int pointerValue;
  final bool isPointerHovering;
  HorizontalBarPlotBarState(
      this.pointerPosition, this.pointerValue, this.isPointerHovering);
}
