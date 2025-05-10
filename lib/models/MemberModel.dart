import 'package:cloud_firestore/cloud_firestore.dart';

class MemberModel {
  final String id;
  final String? teamACatcher;
  final String? teamACenterField;
  final String? teamAFirstBase;
  final String? teamALeftField;
  final String? teamAPitcher;
  final String? teamARightField;
  final String? teamASecondBase;
  final String? teamAShortStop;
  final String? teamAThirdBase;
  final String? teamBCatcher;
  final String? teamBCenterField;
  final String? teamBFirstBase;
  final String? teamBLeftField;
  final String? teamBPitcher;
  final String? teamBRightField;
  final String? teamBSecondBase;
  final String? teamBShortStop;
  final String? teamBThirdBase;

  MemberModel({
    required this.id,
    this.teamACatcher,
    this.teamACenterField,
    this.teamAFirstBase,
    this.teamALeftField,
    this.teamAPitcher,
    this.teamARightField,
    this.teamASecondBase,
    this.teamAShortStop,
    this.teamAThirdBase,
    this.teamBCatcher,
    this.teamBCenterField,
    this.teamBFirstBase,
    this.teamBLeftField,
    this.teamBPitcher,
    this.teamBRightField,
    this.teamBSecondBase,
    this.teamBShortStop,
    this.teamBThirdBase,
  });

  factory MemberModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MemberModel(
      id: data['id'] ?? doc.id,
      teamACatcher: data['teamACatcher'],
      teamACenterField: data['teamACenterField'],
      teamAFirstBase: data['teamAFirstBase'],
      teamALeftField: data['teamALeftField'],
      teamAPitcher: data['teamAPitcher'],
      teamARightField: data['teamARightField'],
      teamASecondBase: data['teamASecondBase'],
      teamAShortStop: data['teamAShortStop'],
      teamAThirdBase: data['teamAThirdBase'],
      teamBCatcher: data['teamBCatcher'],
      teamBCenterField: data['teamBCenterField'],
      teamBFirstBase: data['teamBFirstBase'],
      teamBLeftField: data['teamBLeftField'],
      teamBPitcher: data['teamBPitcher'],
      teamBRightField: data['teamBRightField'],
      teamBSecondBase: data['teamBSecondBase'],
      teamBShortStop: data['teamBShortStop'],
      teamBThirdBase: data['teamBThirdBase'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'teamACatcher': teamACatcher,
      'teamACenterField': teamACenterField,
      'teamAFirstBase': teamAFirstBase,
      'teamALeftField': teamALeftField,
      'teamAPitcher': teamAPitcher,
      'teamARightField': teamARightField,
      'teamASecondBase': teamASecondBase,
      'teamAShortStop': teamAShortStop,
      'teamAThirdBase': teamAThirdBase,
      'teamBCatcher': teamBCatcher,
      'teamBCenterField': teamBCenterField,
      'teamBFirstBase': teamBFirstBase,
      'teamBLeftField': teamBLeftField,
      'teamBPitcher': teamBPitcher,
      'teamBRightField': teamBRightField,
      'teamBSecondBase': teamBSecondBase,
      'teamBShortStop': teamBShortStop,
      'teamBThirdBase': teamBThirdBase,
    };
  }

  // ポジション別にプレイヤーを取得するヘルパーメソッド
  Map<String, String?> getTeamAPlayers() {
    return {
      '投手': teamAPitcher,
      '捕手': teamACatcher,
      '一塁手': teamAFirstBase,
      '二塁手': teamASecondBase,
      '三塁手': teamAThirdBase,
      '遊撃手': teamAShortStop,
      '左翼手': teamALeftField,
      '中堅手': teamACenterField,
      '右翼手': teamARightField,
    };
  }

  Map<String, String?> getTeamBPlayers() {
    return {
      '投手': teamBPitcher,
      '捕手': teamBCatcher,
      '一塁手': teamBFirstBase,
      '二塁手': teamBSecondBase,
      '三塁手': teamBThirdBase,
      '遊撃手': teamBShortStop,
      '左翼手': teamBLeftField,
      '中堅手': teamBCenterField,
      '右翼手': teamBRightField,
    };
  }

  // ポジション名をFirestoreのフィールド名に変換
  static String getFieldName(String team, String position) {
    String prefix = team == 'A' ? 'teamA' : 'teamB';
    switch (position) {
      case '投手':
        return '${prefix}Pitcher';
      case '捕手':
        return '${prefix}Catcher';
      case '一塁手':
        return '${prefix}FirstBase';
      case '二塁手':
        return '${prefix}SecondBase';
      case '三塁手':
        return '${prefix}ThirdBase';
      case '遊撃手':
        return '${prefix}ShortStop';
      case '左翼手':
        return '${prefix}LeftField';
      case '中堅手':
        return '${prefix}CenterField';
      case '右翼手':
        return '${prefix}RightField';
      default:
        return '';
    }
  }
}