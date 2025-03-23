// bloc/grid_bloc.dart
import 'package:flutter/material.dart';
import '../enum/game_modes.dart';
import '../enum/player_types.dart';

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
    return '(R$row, C$column)';
  }
}