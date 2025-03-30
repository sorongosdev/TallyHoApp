// bloc/grid_bloc.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tally_ho/enum/turn_types.dart';
import 'package:tally_ho/services/game_state.dart';
import '../enum/game_modes.dart';
import '../enum/player_types.dart';
import '../models/card_type.dart';
import '../models/card_direction.dart';
import '../models/card_data.dart';
import '../consts/grid_consts.dart';

class GridBloc extends ChangeNotifier {
  final int _itemCount = GridConsts.gridItemCount;
  int get itemCount => _itemCount;

  // 그리드 행/열 수를 7로 고정
  final int _rows = GridConsts.gridRows;
  int get rows => _rows;

  final int _columns = GridConsts.gridColumns;
  int get columns => _columns;

  List<int> _selectedIndices = [];
  List<int> get selectedIndices => _selectedIndices;

  int? _fromIndex;
  int? get fromIndex => _fromIndex;
  int? _toIndex;
  int? get toIndex => _toIndex;

  final GameState _gameState = GameState();

  // ignore: prefer_final_fields
  GameMode get currentMode => _gameState.currentMode; // 기본 모드는 뒤집기

  PlayerType get currentType => _gameState.currentType; // 기본 플레이어 타입은 인간

  TurnTypes get currentTurn => _gameState.currentTurn; // 기본 턴은 나

  CardType get currentCardType => _gameState.currentCardType; // 기본 카드 타입은 숨김

  CardDirection get currentCardDirection =>
      _gameState.currentCardDirection; // 기본 카드 방향은 위쪽

  // 각 그리드 아이템의 카드 데이터를 저장하는 리스트
  // ignore: prefer_final_fields
  List<CardData> _cardDataList = List.generate(49, (_) => CardData.hidden());

  // 아이템 선택 메서드
  void selectItem(int index) {
    // 이미 선택된 아이템을 다시 탭하면 선택 해제
    if (_selectedIndices.contains(index)) {
      _selectedIndices.remove(index);
    } else {
      // 선택된 카드가 2개 이상일 경우, 가장 오래된 카드부터 선택 해제
      if (_selectedIndices.length >= 2) {
        _selectedIndices.removeAt(0);
      }
      _selectedIndices.add(index);
    }
    notifyListeners();
  }

  // 아이템의 텍스트 가져오기 (원본 코드와 동일)
  String getItemText(int index) {
    final row = (index ~/ _columns);
    final column = (index % _columns);
    return 'R${row}C$column';
  }

  // 특정 인덱스의 카드 데이터 반환
  CardData getCardData(int index) {
    if (index < 0 || index >= _itemCount) {
      return CardData.hidden();
    }
    return _cardDataList[index];
  }

  void changeCardType(CardType type) {
    _gameState.currentCardType = type;
    notifyListeners();
  }

  void changeCardDirection(CardDirection direction) {
    _gameState.currentCardDirection = direction;
    notifyListeners();
  }

  bool isSelected(int index){
    return _selectedIndices.contains(index);
  }

  // 카드 뒤집기 동작
  void flipCard(int index) {
    if (index < 0 || index >= _itemCount) return;
    if (currentMode != GameMode.flip) return;
    if (!isSelected(index)) return; // 선택된 카드만 뒤집을 수 있음

    final currentData = _cardDataList[index];
    if (currentData.type == CardType.hidden) {
      changeCardType(CardType.bear);
      changeCardDirection(CardDirection.right);
      _cardDataList[index] = CardData(
        type: currentCardType,
        direction: currentCardDirection,
        isFlipped: true,
      );
    }

    notifyListeners();
  }

  void moveCard(int fromIndex, int toIndex) {
    if (fromIndex < 0 || fromIndex >= _itemCount) return;
    if (toIndex < 0 || toIndex >= _itemCount) return;
    if (fromIndex == toIndex) return; // 같은 인덱스는 이동하지 않음

    final fromData = _cardDataList[fromIndex];
    final toData = _cardDataList[toIndex];

    // 카드 이동 로직
    _cardDataList[toIndex] = fromData;
    _cardDataList[fromIndex] = toData;

    notifyListeners();
  }
}
