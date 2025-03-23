// widgets/grid_item_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/grid_bloc.dart';

class GridItemWidget extends StatelessWidget {
  final int index;

  const GridItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final gridBloc = Provider.of<GridBloc>(context);
    final isSelected = gridBloc.selectedIndex == index;

    return GestureDetector(
      onTap: () {
        gridBloc.selectItem(index);
      },
      child: Stack(
        children: [
          // 기본 카드 이미지
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/card_back.png'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.black, width: 1.0),
            ),
          ),
          
          // 선택 효과 레이어 (선택된 경우에만 보임)
          if (isSelected)
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(150, 136, 174, 191), // 투명도 추가
              ),
            ),
          
          // 텍스트 레이어
          Center(
            child: Text(
              gridBloc.getItemText(index),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}