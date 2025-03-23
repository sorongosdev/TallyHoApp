// screens/grid_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/grid_bloc.dart';
import '../widgets/grid_view_widget.dart';
import '../enum/game_modes.dart';
import '../enum/player_types.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

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

  // 팀
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
    return Scaffold(
      body: Consumer<GridBloc>(
        builder: (context, gridBloc, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final screenHeight = constraints.maxHeight;
              final screenWidth = constraints.maxWidth;

              // BLoC에서 행과 열 정보 가져오기
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
                  Column(
                    children: [
                      SizedBox(height: 50),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // Row를 사용해 오른쪽 정렬
                        children: [
                          Container(
                            color: Colors.yellow,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${_getModeDisplayName(gridBloc.currentMode)} 모드',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // Row를 사용해 오른쪽 정렬
                        children: [
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
                    ],
                  ),

                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (gridBloc.selectedIndex != null) {
                              gridBloc.flipCard(gridBloc.selectedIndex!);
                            } else {
                              // 선택된 카드가 없으면 메시지 출력
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('카드를 선택해주세요.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: const Text('뒤집기'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
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
