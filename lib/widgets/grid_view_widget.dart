// widgets/grid_view_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/grid_bloc.dart';
import 'grid_item_widget.dart';

class GridViewWidget extends StatelessWidget {
  final double cellSize;
  final EdgeInsets margin;

  const GridViewWidget({
    super.key,
    required this.cellSize,
    this.margin = const EdgeInsets.all(14.0), // 기본 외곽 마진 값
  });

  @override
  Widget build(BuildContext context) {
    final gridBloc = Provider.of<GridBloc>(context);
    
    return Container(
      margin: margin,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화
        crossAxisCount: gridBloc.columns, // BLoC에서 열 개수 가져오기
        childAspectRatio: 1.0, // 정사각형 비율
        padding: EdgeInsets.zero, // 패딩 제거
        children: List.generate(gridBloc.itemCount, (index) {
          return GridItemWidget(index: index);
        }),
      ),
    );
  }
}