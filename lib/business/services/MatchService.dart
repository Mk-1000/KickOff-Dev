import '../../domain/entities/Match.dart';
import '../../domain/repositories/IMatchRepository.dart';
import '../../domain/services/IMatchService.dart';

class MatchService implements IMatchService {
  final IMatchRepository _matchRepository;

  MatchService(this._matchRepository);

  @override
  Future<void> createMatch(Match match) async {
    try {
      await _matchRepository.addMatch(match);
    } catch (e) {
      throw Exception('Failed to create match: $e');
    }
  }

  @override
  Future<List<Match>> getMatchesForStadium(String stadiumId) async {
    try {
      return await _matchRepository.getMatchesForStadium(stadiumId);
    } catch (e) {
      throw Exception('Failed to get matches for stadium: $e');
    }
  }

  @override
  Future<void> updateMatchDetails(Match match) async {
    try {
      await _matchRepository.updateMatch(match);
    } catch (e) {
      throw Exception('Failed to update match details: $e');
    }
  }
}
