// bloc/grid_bloc.dart
import 'package:flutter/material.dart';
import '../enum/game_modes.dart';
import '../enum/player_types.dart';
import '../enum/card_types.dart';

class GridBloc extends ChangeNotifier {
  // 원본 코드와 일치하도록 49개 고정 아이템
  final int _itemCount = 49;
  int get itemCount => _itemCount;

  // 그리드 행/열 수를 7로 고정
  final int _rows = 7;
  int get rows => _rows;

  final int _columns = 7;
  int get columns => _columns;

  // 선택된 아이템 인덱스
  int? _selectedIndex;
  int? get selectedIndex => _selectedIndex;

  // 현재 게임 모드를 저장하는 변수
  // ignore: prefer_final_fields
  GameMode _currentMode = GameMode.flip; // 기본 모드는 뒤집기
  GameMode get currentMode => _currentMode;

  // ignore: prefer_final_fields
  PlayerType _currentType = PlayerType.human; // 일단 사람으로 세팅
  PlayerType get currentType => _currentType;

  // 각 카드의 타입을 저장하는 맵
  final Map<int, CardType> _cardTypes = {};

  // 카드가 뒤집혔는지 확인하는 변수
  final Set<int> _flippedCards = {};

  // 특정 카드가 뒤집혔는지 확인
  bool isCardFlipped(int index) {
    return _flippedCards.contains(index);
  }

  // 카드 이미지를 가져오는 메서드
  String getCardImage(int index) {
    // 뒤집힌 카드가 아니면 뒷면 이미지 반환
    if (!isCardFlipped(index)) {
      return 'assets/images/card_back.png';
    }

    // 뒤집힌 카드면 해당 카드 타입에 맞는 이미지 반환
    switch (_cardTypes[index] ?? CardType.hidden) {
      case CardType.hunter:
        return 'assets/images/hunter.png';
      case CardType.bear:
        return 'assets/images/bear.png';
      case CardType.duck:
        return 'assets/images/duck.png';
      case CardType.fox:
        return 'assets/images/fox.png';
      case CardType.goose:
        return 'assets/images/goose.png';
      case CardType.woodcutter:
        return 'assets/images/woodcutter.png';
      case CardType.fatTree:
        return 'assets/images/fat_tree.png';
      case CardType.skinnyTree:
        return 'assets/images/skinny_tree.png';
      case CardType.hidden:
      default:
        return 'assets/images/card_back.png';
    }
  }

  // 카드 뒤집기 메서드
  void flipCard() {
    if (_selectedIndex != null) {
      final index = _selectedIndex!;
      _flippedCards.add(index);
      _cardTypes[index] = CardType.hunter; // 현재는 hunter로 고정
      notifyListeners();
    }
  }

  // 아이템 선택 메서드
  void selectItem(int index) {
    if (_selectedIndex == index) {
      // 이미 선택된 아이템을 다시 탭하면 선택 해제
      _selectedIndex = null;
    } else {
      _selectedIndex = index;
    }
    notifyListeners();
  }

  // 아이템의 텍스트 가져오기 (원본 코드와 동일)
  String getItemText(int index) {
    final row = (index ~/ _columns);
    final column = (index % _columns);
    return 'R${row}C$column';
  }
}
