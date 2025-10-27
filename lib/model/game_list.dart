import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/game_providers.dart';
import '../model/game_list_item.dart';

class GameListView extends ConsumerWidget {
  const GameListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGameList = ref.watch(gameListProvider);

    return asyncGameList.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(color: Color(0xFFBEF264)),
        ),
      ),
      error: (err, stack) => Center(
        child: Text(
          'Không thể tải danh sách game: $err',
          style: const TextStyle(color: Colors.red),
        ),
      ),
      data: (games) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            return GameListItem(game: game);
          },
        );
      },
    );
  }
}