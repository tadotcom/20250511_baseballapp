import 'package:flutter/material.dart';
import '../models/GameModel.dart';

class GameListViewModel extends ChangeNotifier {
  List<GameModel> _games = [];

  List<GameModel> get games => _games;

  // 通常はここでAPIやデータベースからデータを取得します
  Future<void> fetchGames() async {
    // サンプルデータを設定
    _games = [
      GameModel(
        gameTitle: '東京ダービー 2025',
        gameTime: '2025/05/20 13;00',
        gameLocation: '国立競技場',
        gameAddress: '東京都新宿区霞ヶ丘町10-1',
      ),
      GameModel(
        gameTitle: '大阪カップ 決勝戦',
        gameTime: '2025/05/20 13;00',
        gameLocation: 'ヤンマースタジアム長居',
        gameAddress: '大阪府大阪市東住吉区長居公園1-1',
      ),
      GameModel(
        gameTitle: '名古屋オープン',
        gameTime: '2025/05/20 13;00',
        gameLocation: '豊田スタジアム',
        gameAddress: '愛知県豊田市千石町7-2',
      ),
      GameModel(
        gameTitle: '福岡チャンピオンシップ',
        gameTime: '2025/05/20 13;00',
        gameLocation: 'レベルファイブスタジアム',
        gameAddress: '福岡県福岡市東区香椎浜ふ頭1-1-1',
      ),
      GameModel(
        gameTitle: '札幌ウィンターカップ',
        gameTime: '2025/05/20 13;00',
        gameLocation: '札幌ドーム',
        gameAddress: '北海道札幌市豊平区羊ケ丘1番地',
      ),
    ];
    notifyListeners();
  }
}