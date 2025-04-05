// bloc/grid_bloc.dart
import 'package:flutter/foundation.dart';
import '../enum/game_modes.dart';
import '../enum/player_types.dart';
import '../enum/turn_types.dart';
import '../models/card_type.dart';
import '../models/card_direction.dart';
import '../models/card_data.dart';
import '../consts/grid_consts.dart';
import '../services/game_state.dart';

class GridBloc extends ChangeNotifier {
  // 그리드 상수
  final int _itemCount = GridConsts.gridItemCount;
  int get itemCount => _itemCount;

  final int _rows = GridConsts.gridRows;
  int get rows => _rows;

  final int _columns = GridConsts.gridColumns;
  int get columns => _columns;

  // 선택된 인덱스 관리
  List<int> _selectedIndices = [];
  List<int> get selectedIndices => _selectedIndices;

  // 카드 이동을 위한 인덱스
  int? _fromIndex;
  int? get fromIndex => _fromIndex;
  int? _toIndex;
  int? get toIndex => _toIndex;

  // 게임 상태 (외부에서 주입)
  final GameState _gameState;
  
  // 게임 상태 getter들
  GameMode get currentMode => _gameState.currentMode;
  PlayerType get currentType => _gameState.currentType;
  TurnTypes get currentTurn => _gameState.currentTurn;
  CardType get currentCardType => _gameState.currentCardType;
  CardDirection get currentCardDirection => _gameState.currentCardDirection;

  // 카드 데이터 리스트
  List<CardData> _cardDataList = List.generate(
    GridConsts.gridItemCount, 
    (_) => CardData.hidden()
  );
  List<CardData> get cardDataList => List.unmodifiable(_cardDataList);

  // 생성자 - 외부에서 GameState를 주입받음
  GridBloc(this._gameState) {
    // GameState의 변경 이벤트를 감지하여 GridBloc도 업데이트
    _gameState.addListener(_onGameStateChanged);
  }

  // GameState 변경 시 호출되는 콜백
  void _onGameStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    // 메모리 누수 방지를 위해 리스너 제거
    _gameState.removeListener(_onGameStateChanged);
    super.dispose();
  }

  // 아이템 선택 메서드
  void selectItem(int index) {
    // 상대 턴일 때는 선택 불가
    if (currentTurn == TurnTypes.opponent) return;
    
    // 이미 선택된 아이템을 다시 탭하면 선택 해제
    if (_selectedIndices.contains(index)) {
      _selectedIndices.remove(index);
      
      // fromIndex나 toIndex 초기화
      if (_fromIndex == index) _fromIndex = null;
      if (_toIndex == index) _toIndex = null;
    } else {
      // 선택된 카드가 2개 이상일 경우, 가장 오래된 카드부터 선택 해제
      if (_selectedIndices.length >= 2) {
        _selectedIndices.removeAt(0);
      }
      _selectedIndices.add(index);

      // fromIndex와 toIndex 설정
      if (_selectedIndices.length == 1) {
        _fromIndex = index;
      } else if (_selectedIndices.length == 2) {
        _toIndex = index;
      }
    }

    notifyListeners();
  }

  // 특정 인덱스의 카드 데이터 반환
  CardData getCardData(int index) {
    if (index < 0 || index >= _itemCount) {
      return CardData.hidden();
    }
    return _cardDataList[index];
  }

  // 카드 타입 변경
  void changeCardType(CardType type) {
    _gameState.currentCardType = type;
  }

  // 카드 방향 변경
  void changeCardDirection(CardDirection direction) {
    _gameState.currentCardDirection = direction;
  }

  // 선택 여부 확인
  bool isSelected(int index) {
    return _selectedIndices.contains(index);
  }

  // 카드 뒤집기 동작
  void flipCard(int index) {
    // 유효성 검증
    if (index < 0 || index >= _itemCount) return;
    if (currentMode != GameMode.flip) return;
    if (!isSelected(index)) return;
    if (currentTurn == TurnTypes.opponent) return;

    final currentData = _cardDataList[index];
    
    // 숨겨진 카드일 경우만 뒤집기 가능
    if (currentData.type == CardType.hidden) {
      _cardDataList[index] = CardData(
        type: currentCardType,
        direction: currentCardDirection,
        isFlipped: true,
      );
      
      // 턴 변경
      _gameState.toggleTurn();
      
      // 선택 초기화
      clearSelection();
    }

    notifyListeners();
  }

  // 카드 이동 동작
  void moveCard(int fromIndex, int toIndex) {
    // 유효성 검증
    if (fromIndex < 0 || fromIndex >= _itemCount) return;
    if (toIndex < 0 || toIndex >= _itemCount) return;
    if (fromIndex == toIndex) return;
    if (currentTurn == TurnTypes.opponent) return;
    if (!_gameState.isMovable) return;

    // 카드 데이터 교환
    final fromData = _cardDataList[fromIndex];
    final toData = _cardDataList[toIndex];
    _cardDataList[toIndex] = fromData;
    _cardDataList[fromIndex] = toData;

    // 로그 출력
    print('Card moved from $fromIndex to $toIndex');
    
    // 턴 변경
    _gameState.toggleTurn();
    
    // 선택 초기화
    clearSelection();

    notifyListeners();
  }
  
  // 턴 넘기기
  void passTurn() {
    _gameState.toggleTurn();
    clearSelection();
    notifyListeners();
  }
  
  // 선택 초기화
  void clearSelection() {
    _selectedIndices.clear();
    _fromIndex = null;
    _toIndex = null;
    notifyListeners();
  }
}