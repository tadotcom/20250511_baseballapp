import 'package:flutter/material.dart';
import '../GameListCard.dart';
import '../viewmodels/GameListViewModel.dart';
import 'AppDescriptionScreen.dart';
import 'UserGamesScreen.dart';
import 'package:provider/provider.dart';

class GameListView extends StatefulWidget {
  const GameListView({Key? key}) : super(key: key);

  @override
  State<GameListView> createState() => _GameListViewState();
}

class _GameListViewState extends State<GameListView> {
  @override
  void initState() {
    super.initState();
    // 画面が表示された後にデータを取得
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GameListViewModel>(context, listen: false).fetchGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('試合一覧'),
        actions: [
          // アプリの説明ボタン
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'アプリの説明',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppDescriptionScreen(),
                ),
              );
            },
          ),
          // 参加試合一覧ボタン
          IconButton(
            icon: const Icon(Icons.sports),
            tooltip: '参加試合一覧',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => GameListViewModel(),
                    child: const UserGamesScreen(),
                  ),
                ),
              );
            },
          ),
          // ログアウトボタン
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'ログアウト',
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ログアウト'),
        content: const Text('ログアウトしますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // ここでログアウト処理を実装
              // 今回はスナックバーで表示のみ
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('ログアウトしました'),
                ),
              );
            },
            child: const Text('ログアウト'),
          ),
        ],
      ),
    );
  }
}