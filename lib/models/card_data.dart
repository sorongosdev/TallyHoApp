// models/card_data.dart
import 'card_type.dart';
import 'card_direction.dart';

class CardData {
  final CardType type;
  final CardDirection direction;
  final bool isFlipped;

  const CardData({
    required this.type,
    required this.direction,
    this.isFlipped = false,
  });

  // 카드를 뒤집은 상태로 복제
  CardData flip() {
    return CardData(
      type: type,
      direction: direction,
      isFlipped: !isFlipped,
    );
  }

  // 방향을 변경한 상태로 복제
  CardData withDirection(CardDirection newDirection) {
    return CardData(
      type: type,
      direction: newDirection, 
      isFlipped: isFlipped,
    );
  }

  // 숨겨진 카드 생성 (뒷면)
  static CardData hidden() {
    return CardData(
      type: CardType.hidden,
      direction: CardDirection.up,
      isFlipped: false,
    );
  }
}