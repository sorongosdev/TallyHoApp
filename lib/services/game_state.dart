import 'dart:ffi';

import '../enum/game_modes.dart';
import '../enum/player_types.dart';
import '../enum/turn_types.dart';
import '../models/card_direction.dart';
import '../models/card_type.dart';

class GameState {
  static final GameState _instance = GameState._internal();

  factory GameState() {
    return _instance;
  }

  // Singleton instance
  GameState._internal();

  GameMode _currentMode = GameMode.flip;
  GameMode get currentMode => _currentMode;
  set currentMode(GameMode mode) => _currentMode = mode;
  
  PlayerType _currentType = PlayerType.human;
  PlayerType get currentType => _currentType;
  set currentType(PlayerType type) => _currentType = type;

  TurnTypes _currentTurn = TurnTypes.me;
  TurnTypes get currentTurn => _currentTurn;
  set currentTurn(TurnTypes turn) => _currentTurn = turn;

  CardType _currentCardType = CardType.hidden;
  CardType get currentCardType => _currentCardType;
  set currentCardType(CardType type) => _currentCardType = type;

  CardDirection _currentCardDirection = CardDirection.up;
  CardDirection get currentCardDirection => _currentCardDirection;
  set currentCardDirection(CardDirection direction) => _currentCardDirection = direction;

  bool _isMovable = true;
  bool get isMovable => _isMovable;
  set isMovable(bool movable) => _isMovable = movable;
}