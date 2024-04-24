import '../entities/Match.dart';

abstract class IMatchRepository {
  Future<List<Match>> getAllMatches();
  Future<Match> getMatchById(String id);
  Future<void> addMatch(Match match);
  Future<void> updateMatch(Match match);
  Future<void> deleteMatch(String id);
  Future<List<Match>> getMatchesForStadium(String stadiumId);
}
