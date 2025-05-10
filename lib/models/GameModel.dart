import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  final String gameTitle;
  final String gameTime;  // Firestoreでは "gameDay"
  final String gameLocation;
  final String gameAddress;
  final String? id;

  GameModel({
    required this.gameTitle,
    required this.gameTime,
    required this.gameLocation,
    required this.gameAddress,
    this.id,
  });

  // FirestoreのDocumentSnapshotからGameModelインスタンスを作成
  factory GameModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return GameModel(
      id: doc.id,
      gameTitle: data['gameTitle'] ?? '',
      gameTime: data['gameDay'] ?? '',  // Firestoreのフィールド名に合わせる
      gameLocation: data['gameLocation'] ?? '',
      gameAddress: data['gameAddress'] ?? '',
    );
  }

  // GameModelをFirestoreに保存するためのMapに変換
  Map<String, dynamic> toFirestore() {
    return {
      'gameTitle': gameTitle,
      'gameDay': gameTime,  // Firestoreのフィールド名に合わせる
      'gameLocation': gameLocation,
      'gameAddress': gameAddress,
    };
  }
}