abstract class HorizontalBarEvent {}

class HorizontalBarOnValueChangeEvent extends HorizontalBarEvent {
  final int submittedValue;
  final int totalRange;
  final double totalWidth;
  HorizontalBarOnValueChangeEvent(
      this.submittedValue, this.totalRange, this.totalWidth);
}

class HorizontalBarValueSubmitEvent extends HorizontalBarEvent {
  final int submittedValue;
  final int totalRange;
  final double totalWidth;
  HorizontalBarValueSubmitEvent(
      this.submittedValue, this.totalRange, this.totalWidth);
}
