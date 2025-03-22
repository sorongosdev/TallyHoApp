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
            
            // 7개 행에 맞추기 위한 셀 크기 계산
            final cellSize = screenHeight / 7;
            
            return Center(
              child: SizedBox(
                width: cellSize * 7, // 7개의 열을 위한 너비
                height: screenHeight, // 화면 높이 전체 사용
                child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.0, // 정사각형 비율
                ),
                itemCount: 49,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    child: Center(
                      child: Text(
                        'Item $index',
                        style: TextStyle(
                          fontSize: 12.0, // 폰트 크기
                          color: Colors.black, // 폰트 색상
                        ),
                      ),
                    ),
                  );
                },
              ),
              ),
            );
          },
        ),
        // 화면 중앙에 그리드 배치
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}