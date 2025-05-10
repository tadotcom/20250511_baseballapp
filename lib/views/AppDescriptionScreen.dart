import 'package:flutter/material.dart';

class AppDescriptionScreen extends StatelessWidget {
  const AppDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アプリの説明'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'スポーツマッチングアプリ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'このアプリは、スポーツの試合に参加したい人と主催者をマッチングするアプリです。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              '主な機能',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildFeatureItem('試合の検索と閲覧'),
            _buildFeatureItem('チームへの参加申し込み'),
            _buildFeatureItem('ポジション別の参加管理'),
            _buildFeatureItem('参加試合の確認'),
            const SizedBox(height: 24),
            const Text(
              '使い方',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildUsageItem('1. 試合一覧から参加したい試合を選択'),
            _buildUsageItem('2. 試合詳細画面で空いているポジションを確認'),
            _buildUsageItem('3. 参加可能ボタンをタップして参加申し込み'),
            _buildUsageItem('4. 参加試合一覧で自分の参加試合を確認'),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 20, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}