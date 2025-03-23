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
    final isFlipped = gridBloc.isCardFlipped(index);

    return GestureDetector(
      onTap: () {
        gridBloc.selectItem(index);
      },
      child: Stack(
        children: [
          // 카드 이미지
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(gridBloc.getCardImage(index)),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.black, width: 1.0),
            ),
          ),
          
          // 선택 효과 레이어 (선택되었지만 아직 뒤집히지 않은 경우에만 보임)
          if (isSelected && !isFlipped)
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(150, 136, 174, 191), // 투명도 추가
              ),
            ),
          
          // 텍스트 레이어 (카드가 뒤집히지 않았을 때만 보임)
          if (!isFlipped)
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