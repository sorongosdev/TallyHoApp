// screens/grid_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/grid_bloc.dart';
import '../widgets/grid_view_widget.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

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
              
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: verticalMargin,
                    horizontal: horizontalMargin,
                  ),
                  width: gridWidth,
                  height: gridHeight,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: GridViewWidget(cellSize: cellSize),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}