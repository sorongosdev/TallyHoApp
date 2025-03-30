import '../enum/game_modes.dart';
import '../enum/player_types.dart';
import '../enum/turn_types.dart';

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
}