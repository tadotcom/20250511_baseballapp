import 'package:flutter/material.dart';
import '../GameListCard.dart';
import '../viewmodels/GameListViewModel.dart';
import 'package:provider/provider.dart';

class UserGamesScreen extends StatefulWidget {
  const UserGamesScreen({Key? key}) : super(key: key);

  @override
  State<UserGamesScreen> createState() => _UserGamesScreenState();
}

class _UserGamesScreenState extends State<UserGamesScreen> {
  @override
  void initState() {
    super.initState();
    // 通常はここでユーザーの参加試合のみを取得しますが、
    // 今回はサンプルとして全試合を表示
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GameListViewModel>(context, listen: false).fetchGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('参加試合一覧'),
      ),
      body: Consumer<GameListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.games.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: viewModel.games.length,
            itemBuilder: (context, index) {
              return GameListCard(game: viewModel.games[index]);
            },
          );
        },
      ),
    );
  }
}