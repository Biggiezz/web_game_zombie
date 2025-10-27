import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/game.dart';
import '../model/game_repository.dart';

part 'game_providers.g.dart';

@riverpod
GameRepository gameRepository(GameRepositoryRef ref) {
  return GameRepository();
}

@Riverpod(keepAlive: true)
class GameList extends _$GameList {
  @override
  Future<List<Game>> build() {
    final gameRepository = ref.watch(gameRepositoryProvider);
    return gameRepository.fetchGames();
  }

  Future<void> addGame(String gameName) async {
    final newGame = Game(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: gameName,
      linkUrl:
          'https://picsum.photos/50?random=${DateTime.now().millisecondsSinceEpoch}',
    );

    final currentState = state.valueOrNull ?? [];

    state = AsyncData([...currentState, newGame]);

    // (Tùy chọn) 4. Gọi API để lưu game mới lên server
    // final gameRepository = ref.read(gameRepositoryProvider);
    // try {
    //   await gameRepository.uploadNewGame(newGame);
    // } catch (e) {
    //   // Xử lý nếu upload thất bại
    //   // Ví dụ: state = AsyncError(e, stackTrace);
    // }
  }

  Future<void> deleteGame(String gameId) async {
    final currentState = state.valueOrNull ?? [];

    final newState = currentState.where((game) => game.id != gameId).toList();

    state = AsyncData(newState);

    // (Tùy chọn) 4. Pác có thể gọi API để xóa game này khỏi server ở đây
    // final gameRepository = ref.read(gameRepositoryProvider);
    // await gameRepository.deleteGameFromServer(gameId);
  }
}
