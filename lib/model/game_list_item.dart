import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/game.dart';
import '../provider/game_providers.dart';

class GameListItem extends ConsumerWidget {
  final Game game;

  const GameListItem({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(game.id),
      onDismissed: (direction) {
        ref.read(gameListProvider.notifier).deleteGame(game.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${game.name} đã được xóa.'),
            backgroundColor: Colors.red[700],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red[700],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        color: Colors.grey[900],
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          leading: Image.network(
            game.linkUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error, color: Colors.red),
          ),
          title: Text(
            game.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'ID: ${game.id}',
            style: const TextStyle(color: Colors.grey),
          ),
          // trailing: IconButton(
          //   icon: Icon(Icons.delete_outline, color: Colors.red[300]),
          //   tooltip: 'Xóa game',
          //   onPressed: () {
          //     ref.read(gameListProvider.notifier).deleteGame(game.id);
          //   },
          // ),
          onTap: () {
            print('Bạn đã nhấn vào game: ${game.name}');
            // Navigator.push(...);
          },
        ),
      ),
    );
  }
}
