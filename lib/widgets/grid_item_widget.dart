// widgets/grid_item_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tally_ho/enum/game_modes.dart';
import 'package:tally_ho/services/game_state.dart';
import 'dart:math' as math;
import '../bloc/grid_bloc.dart';
import '../models/card_direction.dart';
import '../enum/turn_types.dart';

class GridItemWidget extends StatelessWidget {
  final int index;

  const GridItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final gridBloc = Provider.of<GridBloc>(context);
    final isSelected = gridBloc.selectedIndex == index;
    final cardData = gridBloc.getCardData(index);
    
    // 방향에 따른 회전 각도 설정
    double rotationAngle = 0;
    if (cardData.direction == CardDirection.down) {
      rotationAngle = math.pi / 2; // 90도
    } else if (cardData.direction == CardDirection.left) {
      rotationAngle = math.pi; // 180도
    } else if (cardData.direction == CardDirection.up) {
      rotationAngle = 3 * math.pi / 2; // 270도
    }

    return GestureDetector(
      onTap: () {
        gridBloc.selectItem(index);
      },
      child: Stack(
        children: [
          // 카드 이미지 (카드 타입과 방향에 따라 회전)
          Transform.rotate(
            angle: rotationAngle,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(cardData.type.assetPath),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.black, width: 1.0),
              ),
            ),
          ),
          
          // 선택 효과 레이어 (선택된 경우에만 보임)
          if (isSelected && gridBloc.currentTurn == TurnTypes.me)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(150, 136, 174, 191), // 투명도 추가
              ),
            ),
        ],
      ),
    );
  }
}