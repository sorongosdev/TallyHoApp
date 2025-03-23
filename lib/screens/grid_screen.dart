// screens/grid_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/grid_bloc.dart';
import '../widgets/grid_view_widget.dart';
import '../enum/game_modes.dart';

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

                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      color: Colors.yellow,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _getModeDisplayName(gridBloc.currentMode),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
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
