// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'bloc/grid_bloc.dart';
import 'screens/grid_screen.dart';
import 'services/game_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 가로 모드로 고정
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 먼저 GameState 제공 (싱글톤 대신 Provider로 관리)
        ChangeNotifierProvider(create: (_) => GameState()),
        
        // GameState를 사용하는 GridBloc 제공
        ChangeNotifierProxyProvider<GameState, GridBloc>(
          create: (context) => GridBloc(context.read<GameState>()),
          update: (context, gameState, previousGridBloc) => 
            previousGridBloc ?? GridBloc(gameState),
        ),
      ],
      child: MaterialApp(
        title: 'Tally-Ho',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const GridScreen(),
      ),
    );
  }
}