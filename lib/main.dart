import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kusakusa_20250510/viewmodels/GameListViewModel.dart';
import 'package:kusakusa_20250510/views/GameViewScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print('Firebase初期化成功');
  } catch (e) {
    print('Firebase初期化エラー: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '試合リスト',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => GameListViewModel(),
        child: const GameListView(),
      ),
    );
  }
}