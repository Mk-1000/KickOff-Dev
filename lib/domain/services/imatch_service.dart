import '../../domain/entities/Match.dart';

abstract class IMatchService {
  Future<void> createMatch(Match match);
  Future<void> updateMatchDetails(Match match);
  Future<List<Match>> getMatchesForStadium(String stadiumId);
}
