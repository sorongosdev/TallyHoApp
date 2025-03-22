// widgets/grid_item_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/grid_bloc.dart';

class GridItemWidget extends StatelessWidget {
  final int index;

  const GridItemWidget({
    super.key, 
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final gridBloc = Provider.of<GridBloc>(context);
    final isSelected = gridBloc.selectedIndex == index;
    
    return GestureDetector(
      onTap: () {
        gridBloc.selectItem(index);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          color: isSelected ? Colors.lightBlue[100] : Colors.white,
        ),
        child: Center(
          child: Text(
            gridBloc.getItemText(index),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 20.0,
              color: isSelected ? Colors.blue[800] : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}