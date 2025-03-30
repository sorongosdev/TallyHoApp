// bloc/grid_bloc.dart
import 'package:flutter/material.dart';
import '../enum/game_modes.dart';
import '../enum/player_types.dart';
import '../models/card_type.dart';
import '../models/card_direction.dart';
import '../models/card_data.dart';
import '../consts/game_consts.dart';

class GridBloc extends ChangeNotifier {
  final int _itemCount = GameConsts.gridItemCount;
  int get itemCount => _itemCount;

  // 그리드 행/열 수를 7로 고정
  final int _rows = GameConsts.gridRows;
  int get rows => _rows;

  final int _columns = GameConsts.gridColumns;
  int get columns => _columns;

  // 선택된 아이템 인덱스
  int? _selectedIndex;
  int? get selectedIndex => _selectedIndex;

  // 현재 게임 모드를 저장하는 변수 (하드코딩)
  // ignore: prefer_final_fields
  GameMode _currentMode = GameMode.flip; // 기본 모드는 뒤집기
  GameMode get currentMode => _currentMode;

  // ignore: prefer_final_fields
  PlayerType _currentType = PlayerType.human; // 일단 사람으로 세팅
  PlayerType get currentType => _currentType;

  // 각 그리드 아이템의 카드 데이터를 저장하는 리스트
  // ignore: prefer_final_fields
  List<CardData> _cardDataList = List.generate(49, (_) => CardData.hidden());
  
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
  
  // 특정 인덱스의 카드 데이터 반환
  CardData getCardData(int index) {
    if (index < 0 || index >= _itemCount) {
      return CardData.hidden();
    }
    return _cardDataList[index];
  }

  // 카드 뒤집기 동작
  void flipCard(int index) {
    if (index < 0 || index >= _itemCount) return;
    if (_currentMode != GameMode.flip) return;
    if (_selectedIndex != index) return; // 선택된 카드만 뒤집을 수 있음
    
    final currentData = _cardDataList[index];
    if (currentData.type == CardType.hidden) {

      CardType cardType = CardType.bear; // 기본 카드 타입
      CardDirection direction = CardDirection.up; // 기본 방향
      
      _cardDataList[index] = CardData(
        type: cardType,
        direction: direction,
        isFlipped: true
      );
    }
    
    notifyListeners();
  }
}