class GameDetailModel {
  final String gameTitle;
  final String gameTime;
  final String gameLocation;
  final String gameAddress;
  final Map<String, String?> teamAPlayers;
  final Map<String, String?> teamBPlayers;

  GameDetailModel({
    required this.gameTitle,
    required this.gameTime,
    required this.gameLocation,
    required this.gameAddress,
    required this.teamAPlayers,
    required this.teamBPlayers,
  });
}