// models/card_type.dart
class CardType {
  final String name;
  final String assetPath;

  const CardType({
    required this.name, 
    required this.assetPath,
  });

  // 카드 타입 정적 인스턴스들
  static const CardType bear = CardType(
    name: 'bear',
    assetPath: 'assets/images/bear.png',
  );

  static const CardType duck = CardType(
    name: 'duck',
    assetPath: 'assets/images/duck.png',
  );

  static const CardType fox = CardType(
    name: 'fox',
    assetPath: 'assets/images/fox.png',
  );

  static const CardType goose = CardType(
    name: 'goose',
    assetPath: 'assets/images/goose.png',
  );

  static const CardType hunter = CardType(
    name: 'hunter',
    assetPath: 'assets/images/hunter.png',
  );

  static const CardType woodcutter = CardType(
    name: 'woodcutter',
    assetPath: 'assets/images/woodcutter.png',
  );

  static const CardType fatTree = CardType(
    name: 'fatTree',
    assetPath: 'assets/images/fat_tree.png',
  );

  static const CardType skinnyTree = CardType(
    name: 'skinnyTree',
    assetPath: 'assets/images/skinny_tree.png',
  );

  static const CardType hidden = CardType(
    name: 'hidden',
    assetPath: 'assets/images/card_back.png',
  );

  // 모든 카드 타입 리스트
  static List<CardType> values() => [
    bear, duck, fox, goose, hunter, woodcutter, fatTree, skinnyTree, hidden
  ];

  // id로 카드 타입 찾기
  static CardType fromName(String name) {
    return values().firstWhere(
      (type) => type.name == name,
      orElse: () => hidden,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CardType && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}