import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/GameModel.dart';

class GameListViewModel extends ChangeNotifier {
  List<GameModel> _games = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<GameModel> get games => _games;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FirestoreのgameInfoコレクションからデータを取得
  Future<void> fetchGames() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('Firestoreからデータを取得開始...');
      QuerySnapshot snapshot = await _firestore.collection('gameInfo').get();

      print('取得したドキュメント数: ${snapshot.docs.length}');

      if (snapshot.docs.isEmpty) {
        print('データが存在しません');
        _games = [];
      } else {
        // デバッグ: 最初のドキュメントのデータ構造を表示
        if (snapshot.docs.isNotEmpty) {
          print('最初のドキュメントのデータ: ${snapshot.docs.first.data()}');
        }

        _games = snapshot.docs
            .map((doc) => GameModel.fromFirestore(doc))
            .toList();

        print('変換後のゲーム数: ${_games.length}');
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('エラー発生: $e');
      _errorMessage = 'データの取得に失敗しました: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // リアルタイムでデータの変更を監視する場合
  void listenToGames() {
    _firestore.collection('gameInfo').snapshots().listen(
          (snapshot) {
        print('リアルタイム更新: ドキュメント数 ${snapshot.docs.length}');
        _games = snapshot.docs
            .map((doc) => GameModel.fromFirestore(doc))
            .toList();
        notifyListeners();
      },
      onError: (error) {
        print('リアルタイムエラー: $error');
        _errorMessage = 'データの取得に失敗しました: $error';
        notifyListeners();
      },
    );
  }
}