import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Match.dart';
import '../../domain/repositories/IMatchRepository.dart';
import '../firebase/FirebaseService.dart';

class MatchRepository implements IMatchRepository {
  final FirebaseService _firebaseService;
  final String _collectionPath = 'matches';

  MatchRepository(this._firebaseService);

  // @override
  // Future<List<Match>> getAllMatches() async {
  //   DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
  //   if (snapshot.exists && snapshot.value != null) {
  //     Map<dynamic, dynamic> matchesMap =
  //         (snapshot.value as Map).cast<dynamic, dynamic>();
  //     return matchesMap.values
  //         .map((e) => Match.fromJson(Map<String, dynamic>.from(e as Map)))
  //         .toList();
  //   }
  //   return [];
  // }

  @override
  Future<List<Match>> getAllMatches() async {
    // Use Stream to listen for changes in real-time
    final Stream<DatabaseEvent> stream =
        _firebaseService.getCollectionStream(_collectionPath);

    // Handle initial data and subsequent updates
    final matchs = <Match>[];
    stream.listen((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          matchs.add(Match.fromJson(Map<String, dynamic>.from(value)));
        });
      }
    });

    return matchs; // Return the initially loaded matchs
  }

  @override
  Future<Match> getMatchById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists && snapshot.value != null) {
      return Match.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    }
    throw Exception('Match not found');
  }

  @override
  Future<void> addMatch(Match match) async {
    await _firebaseService.setDocument(_collectionPath, match.toJson());
  }

  @override
  Future<void> updateMatch(Match match) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${match.matchId}', match.toJson());
  }

  @override
  Future<void> deleteMatch(String id) async {
    await _firebaseService.deleteDocument('$_collectionPath/$id');
  }

  @override
  Future<List<Match>> getMatchesForStadium(String stadiumId) async {
    final query =
        _firebaseService.getCollectionStream(_collectionPath).map((event) {
      return (event.snapshot.value as Map<dynamic, dynamic>)
          .values
          .where((value) =>
              (value as Map<dynamic, dynamic>)['stadiumId'] == stadiumId)
          .map((value) => Match.fromJson(
              Map<String, dynamic>.from(value as Map<dynamic, dynamic>)))
          .toList();
    });

    // Since streams are async and continuous, we need to await the first matching element
    final List<Match> matches = await query.first;
    return matches;
  }
}
