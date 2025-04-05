// services/game_state.dart
import 'package:flutter/foundation.dart';
import '../enum/game_modes.dart';
import '../enum/player_types.dart';
import '../enum/turn_types.dart';
import '../models/card_direction.dart';
import '../models/card_type.dart';

// ChangeNotifier를 상속받아 상태 변경 알림 기능 추가
class GameState extends ChangeNotifier {
  // 싱글톤 패턴 제거 - Provider를 통해 관리할 예정

  // 기본값 설정
  GameMode _currentMode = GameMode.flip;
  GameMode get currentMode => _currentMode;
  set currentMode(GameMode mode) {
    _currentMode = mode;
    notifyListeners(); // 상태 변경 시 알림
  }
  
  PlayerType _currentType = PlayerType.human;
  PlayerType get currentType => _currentType;
  set currentType(PlayerType type) {
    _currentType = type;
    notifyListeners();
  }

  TurnTypes _currentTurn = TurnTypes.me;
  TurnTypes get currentTurn => _currentTurn;
  set currentTurn(TurnTypes turn) {
    _currentTurn = turn;
    notifyListeners();
  }

  CardType _currentCardType = CardType.hidden;
  CardType get currentCardType => _currentCardType;
  set currentCardType(CardType type) {
    _currentCardType = type;
    notifyListeners();
  }

  CardDirection _currentCardDirection = CardDirection.up;
  CardDirection get currentCardDirection => _currentCardDirection;
  set currentCardDirection(CardDirection direction) {
    _currentCardDirection = direction;
    notifyListeners();
  }

  bool _isMovable = true;
  bool get isMovable => _isMovable;
  set isMovable(bool movable) {
    _isMovable = movable;
    notifyListeners();
  }
  
  // 게임 상태 초기화 메서드
  void resetState() {
    _currentMode = GameMode.flip;
    _currentType = PlayerType.human;
    _currentTurn = TurnTypes.me;
    _currentCardType = CardType.hidden;
    _currentCardDirection = CardDirection.up;
    _isMovable = true;
    notifyListeners();
  }
  
  // 턴 변경 메서드
  void toggleTurn() {
    _currentTurn = _currentTurn == TurnTypes.me ? TurnTypes.opponent : TurnTypes.me;
    notifyListeners();
  }
}