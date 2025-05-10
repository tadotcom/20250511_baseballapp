import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/GameDetailModel.dart';
import '../models/GameModel.dart';
import '../models/MemberModel.dart';

class GameDetailViewModel extends ChangeNotifier {
  GameDetailModel? _gameDetail;
  MemberModel? _members;
  bool _isLoading = false;
  String? _errorMessage;

  GameDetailModel? get gameDetail => _gameDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<void> fetchGameDetail(GameModel game) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // ゲーム情報を使用
      print('試合詳細データ読み込み開始: ${game.id}');

      // membersコレクションから該当ゲームIDのメンバー情報を取得
      DocumentSnapshot memberDoc = await _firestore
          .collection('gameInfo')
          .doc(game.id)
          .collection('members')
          .doc(game.id)
          .get();

      if (memberDoc.exists) {
        _members = MemberModel.fromFirestore(memberDoc);
        print('メンバーデータ取得成功');
      } else {
        // メンバーデータが存在しない場合は新規作成
        _members = MemberModel(id: game.id!);
        print('メンバーデータが存在しないため、新規作成');
      }

      // GameDetailModelを作成
      _gameDetail = GameDetailModel(
        gameTitle: game.gameTitle,
        gameTime: game.gameTime,
        gameLocation: game.gameLocation,
        gameAddress: game.gameAddress,
        teamAPlayers: _members?.getTeamAPlayers() ?? _createEmptyTeam(),
        teamBPlayers: _members?.getTeamBPlayers() ?? _createEmptyTeam(),
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('エラー発生: $e');
      _errorMessage = 'データの取得に失敗しました: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, String?> _createEmptyTeam() {
    Map<String, String?> team = {};
    for (String position in positions) {
      team[position] = null;
    }
    return team;
  }

  Future<void> joinGame(String gameId, String team, String position) async {
    try {
      String fieldName = MemberModel.getFieldName(team, position);

      // Firestoreのmembersコレクションを更新
      await _firestore
          .collection('gameInfo')
          .doc(gameId)
          .collection('members')
          .doc(gameId)
          .set({
        fieldName: '宮崎',
        'id': gameId,
      }, SetOptions(merge: true)); // 既存のデータとマージ

      // ローカルの状態も更新
      if (_gameDetail != null) {
        if (team == 'A') {
          _gameDetail!.teamAPlayers[position] = '宮崎';
        } else {
          _gameDetail!.teamBPlayers[position] = '宮崎';
        }
        notifyListeners();
      }

      print('参加登録成功: $team チーム - $position');
    } catch (e) {
      print('参加登録エラー: $e');
      _errorMessage = '参加登録に失敗しました: $e';
      notifyListeners();
    }
  }
}