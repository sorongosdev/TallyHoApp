// screens/grid_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/grid_bloc.dart';
import '../widgets/grid_view_widget.dart';
import '../services/game_state.dart';
import '../enum/game_modes.dart';
import '../enum/player_types.dart';
import '../enum/turn_types.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  // 턴 표시 이름 가져오기
  String _getTurnDisplayName(TurnTypes turn) {
    switch (turn) {
      case TurnTypes.opponent:
        return '상대';
      case TurnTypes.me:
        return '나';
    }
  }

  // 모드 이름 반환
  String _getModeDisplayName(GameMode mode) {
    switch (mode) {
      case GameMode.flip:
        return '뒤집기';
      case GameMode.hunt:
        return '사냥';
      case GameMode.escape:
        return '탈출';
    }
  }

  // 팀 이름 반환
  String _getPlayerTypeDisplayName(PlayerType playerType) {
    switch (playerType) {
      case PlayerType.animal:
        return '동물';
      case PlayerType.human:
        return '인간';
    }
  }

  @override
  Widget build(BuildContext context) {
    // GameState와 GridBloc 모두 접근
    final gameState = Provider.of<GameState>(context);
    
    return Scaffold(
      body: Consumer<GridBloc>(
        builder: (context, gridBloc, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final screenHeight = constraints.maxHeight;
              final screenWidth = constraints.maxWidth;

              // 그리드 정보 가져오기
              final rows = gridBloc.rows;
              final columns = gridBloc.columns;

              // 셀 크기 계산
              final cellSize = (screenHeight / rows).floorToDouble() - 2.0;

              // 그리드 전체 크기 계산
              final gridHeight = cellSize * rows;
              final gridWidth = cellSize * columns;

              // 여백 계산
              final remainingVerticalSpace = screenHeight - gridHeight;
              final verticalMargin = remainingVerticalSpace / 2;

              final remainingHorizontalSpace = screenWidth - gridWidth;
              final horizontalMargin = remainingHorizontalSpace * 0.25;

              return Stack(
                children: [
                  // 게임 보드 (왼쪽)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: verticalMargin,
                        horizontal: horizontalMargin,
                      ),
                      width: gridWidth,
                      height: gridHeight,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/board.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: GridViewWidget(cellSize: cellSize),
                    ),
                  ),
                  
                  // 정보 표시 패널 (오른쪽 상단)
                  Positioned(
                    top: 50,
                    right: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // 턴 정보
                        Container(
                          color: Colors.yellow,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            '${_getTurnDisplayName(gridBloc.currentTurn)}의 차례입니다',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // 게임 모드 정보
                        Container(
                          color: Colors.yellow,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            '${_getModeDisplayName(gridBloc.currentMode)} 모드',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // 플레이어 팀 정보
                        Container(
                          color: Colors.yellow,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '당신은 ${_getPlayerTypeDisplayName(gridBloc.currentType)}팀입니다.',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 액션 버튼 (오른쪽 하단)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Row(
                      children: [
                        // 카드 뒤집기 버튼
                        ElevatedButton(
                          onPressed: gridBloc.currentTurn == TurnTypes.me
                              ? () {
                                  if (gridBloc.selectedIndices.isNotEmpty) {
                                    gridBloc.flipCard(gridBloc.selectedIndices.first);
                                  } else {
                                    // 선택된 카드가 없으면 메시지 출력
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('카드를 선택해주세요.'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                }
                              : null, // 상대 턴이면 비활성화
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gridBloc.currentMode == GameMode.flip
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          child: const Text('뒤집기'),
                        ),
                        
                        const SizedBox(width: 8),
                        
                        // 카드 이동 버튼
                        ElevatedButton(
                          onPressed: gridBloc.currentTurn == TurnTypes.me &&
                                     gridBloc.selectedIndices.length == 2
                              ? () {
                                  gridBloc.moveCard(
                                    gridBloc.fromIndex!,
                                    gridBloc.toIndex!,
                                  );
                                }
                              : null, // 선택된 카드가 2개가 아니면 비활성화
                          child: const Text('이동하기'),
                        ),
                        
                        const SizedBox(width: 8),
                        
                        // 턴 넘기기 버튼
                        ElevatedButton(
                          onPressed: gridBloc.currentTurn == TurnTypes.me
                              ? () => gridBloc.passTurn()
                              : null, // 상대 턴이면 비활성화
                          child: const Text('턴 넘기기'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}