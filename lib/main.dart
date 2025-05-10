import 'package:flutter/material.dart';
import 'package:kusakusa_20250510/viewmodels/GameListViewModel.dart';
import 'package:kusakusa_20250510/views/GameViewScreen.dart';
import 'package:provider/provider.dart';

void main() {
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