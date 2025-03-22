import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 가로 모드로 고정
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int itemCount = 49;

  @override
  Widget build(BuildContext context) {
    const title = 'Grid';

    return MaterialApp(
      title: title,
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            // 화면의 가용 높이를 기준으로 정사각형 그리드 계산
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;
            
            // 7개 행에 맞추기 위한 셀 크기 계산 (정수로 반올림)
            final cellSize = (screenHeight / 7).floorToDouble() - 2.0;
            
            // 그리드 전체 높이 계산 (셀 크기 * 7)
            final gridHeight = cellSize * 7;
            final gridWidth = cellSize * 7;
            
            // 남은 공간으로 마진 계산 (균등하게 분배)
            final remainingVerticalSpace = screenHeight - gridHeight;
            final verticalMargin = remainingVerticalSpace / 2;
            
            // 수평 방향 중앙 정렬을 위한 계산
            final remainingHorizontalSpace = screenWidth - gridWidth;
            final horizontalMargin = remainingHorizontalSpace * 0.25;
            
            // 실제 위치 계산 디버깅
            final topPosition = verticalMargin;
            final leftPosition = horizontalMargin;
            
            return Align(
              alignment: Alignment.centerLeft, // 중앙 정렬로 변경
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: verticalMargin,
                  horizontal: leftPosition,
                ),
                width: gridWidth,
                height: gridHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(), // 스크롤 비활성화
                  crossAxisCount: 7, // 7개의 열
                  childAspectRatio: 1.0, // 정사각형 비율
                  padding: EdgeInsets.zero, // 패딩 제거
                  children: List.generate(49, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                      ),
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}