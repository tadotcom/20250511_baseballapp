import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/GameDetailViewModel.dart';
import '../models/GameModel.dart';

class GameDetailScreen extends StatefulWidget {
  final GameModel game;

  const GameDetailScreen({Key? key, required this.game}) : super(key: key);

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GameDetailViewModel>(context, listen: false)
          .fetchGameDetail(widget.game);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.gameTitle),
      ),
      body: Consumer<GameDetailViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(viewModel.errorMessage!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.fetchGameDetail(widget.game);
                    },
                    child: const Text('再試行'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.gameDetail == null) {
            return const Center(
              child: Text('データがありません'),
            );
          }

          final detail = viewModel.gameDetail!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 試合情報
                _buildGameInfo(detail),
                const Divider(height: 32),
                // チームA
                _buildTeamSection(
                  context,
                  viewModel,
                  'チームA',
                  'A',
                  detail.teamAPlayers,
                  Colors.red,
                ),
                const SizedBox(height: 24),
                // チームB
                _buildTeamSection(
                  context,
                  viewModel,
                  'チームB',
                  'B',
                  detail.teamBPlayers,
                  Colors.blue,
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGameInfo(detail) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.gameTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 20),
              const SizedBox(width: 8),
              Text(
                detail.gameTime,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, size: 20),
              const SizedBox(width: 8),
              Text(
                detail.gameLocation,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.home, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  detail.gameAddress,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection(
      BuildContext context,
      GameDetailViewModel viewModel,
      String teamName,
      String teamId,
      Map<String, String?> players,
      Color teamColor,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            teamName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: teamColor,
            ),
          ),
          const SizedBox(height: 12),
          ...viewModel.positions.map((position) {
            final player = players[position];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      position,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: player != null
                        ? Text(
                      player,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        : ElevatedButton(
                      onPressed: () {
                        _showJoinDialog(context, viewModel, teamId, position);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: teamColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      child: const Text('参加可能'),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showJoinDialog(
      BuildContext context,
      GameDetailViewModel viewModel,
      String team,
      String position,
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('試合参加確認'),
        content: Text('$position で試合に参加しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              viewModel.joinGame(widget.game.id!, team, position);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$position で参加登録しました'),
                ),
              );
            },
            child: const Text('参加する'),
          ),
        ],
      ),
    );
  }
}