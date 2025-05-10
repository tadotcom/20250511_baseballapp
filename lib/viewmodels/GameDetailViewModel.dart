import 'package:flutter/material.dart';
import '../models/GameDetailModel.dart';

class GameDetailViewModel extends ChangeNotifier {
  GameDetailModel? _gameDetail;

  GameDetailModel? get gameDetail => _gameDetail;

  // ポジションのリスト
  final List<String> positions = [
    '投手',
    '捕手',
    '一塁手',
    '二塁手',
    '三塁手',
    '遊撃手',
    '左翼手',
    '中堅手',
    '右翼手',
  ];

  Future<void> fetchGameDetail(String gameTitle) async {
    // 通常はAPIからデータを取得しますが、ここではサンプルデータを使用
    _gameDetail = GameDetailModel(
      gameTitle: gameTitle,
      gameTime: '2025/05/20 13:00',
      gameLocation: '国立競技場',
      gameAddress: '東京都新宿区霞ヶ丘町10-1',
      teamAPlayers: {
        '投手': '田中太郎',
        '捕手': null,
        '一塁手': '佐藤次郎',
        '二塁手': null,
        '三塁手': '高橋三郎',
        '遊撃手': null,
        '左翼手': '山田花子',
        '中堅手': null,
        '右翼手': '鈴木一郎',
      },
      teamBPlayers: {
        '投手': null,
        '捕手': '伊藤五郎',
        '一塁手': null,
        '二塁手': '渡辺六郎',
        '三塁手': null,
        '遊撃手': '中村七郎',
        '左翼手': null,
        '中堅手': '小林八郎',
        '右翼手': null,
      },
    );
    notifyListeners();
  }

  Future<void> joinGame(String team, String position) async {
    // 実際のアプリケーションではAPIを呼び出して参加処理を行う
    // ここではモックとして実装
    if (_gameDetail != null) {
      if (team == 'A') {
        _gameDetail!.teamAPlayers[position] = '自分';
      } else {
        _gameDetail!.teamBPlayers[position] = '自分';
      }
      notifyListeners();
    }
  }
}