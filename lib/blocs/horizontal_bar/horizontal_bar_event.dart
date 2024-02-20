abstract class HorizontalBarEvent {}

class HorizontalBarInitEvent extends HorizontalBarEvent {
  final int totalWidth;
  HorizontalBarInitEvent(this.totalWidth);
}

class HorizontalBarOnValueChangeEvent extends HorizontalBarEvent {
  final int submittedValue;
  HorizontalBarOnValueChangeEvent(this.submittedValue);
}

class HorizontalBarValueSubmitEvent extends HorizontalBarEvent {
  final int submittedValue;
  final int totalRange;
  HorizontalBarValueSubmitEvent(this.submittedValue, this.totalRange);
}
