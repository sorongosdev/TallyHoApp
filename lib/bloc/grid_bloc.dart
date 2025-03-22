// bloc/grid_bloc.dart
import 'package:flutter/material.dart';

class GridBloc extends ChangeNotifier {
  // 원본 코드와 일치하도록 49개 고정 아이템
  final int _itemCount = 49;
  int get itemCount => _itemCount;

  // 그리드 행/열 수를 7로 고정
  final int _rows = 7;
  int get rows => _rows;

  final int _columns = 7;
  int get columns => _columns;

  // 선택된 아이템 인덱스 (선택 기능을 위한 예시)
  int? _selectedIndex;
  int? get selectedIndex => _selectedIndex;

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
    return 'Item $index';
  }
}