import 'game.dart';

class GameRepository {
  Future<List<Game>> fetchGames() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      Game(id: '1', name: 'League of Legends', linkUrl: 'https://whack-a-chibi-zombie.lovable.app'),
      Game(id: '2', name: 'Valorant', linkUrl: 'https://placehold.co/100x100/red/white?text=Valo'),
      Game(id: '3', name: 'Apex Legends', linkUrl: 'https://placehold.co/100x100/orange/white?text=Apex'),
      Game(id: '4', name: 'Overwatch 2', linkUrl: 'https://placehold.co/100x100/blue/white?text=OW2'),
    ];
  }
}
