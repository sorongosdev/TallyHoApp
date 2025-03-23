// models/card_direction.dart
class CardDirection {
  final String value;

  const CardDirection._(this.value);

  static const CardDirection up = CardDirection._('up');
  static const CardDirection down = CardDirection._('down');
  static const CardDirection left = CardDirection._('left');
  static const CardDirection right = CardDirection._('right');

  static const List<CardDirection> values = [up, down, left, right];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CardDirection && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}