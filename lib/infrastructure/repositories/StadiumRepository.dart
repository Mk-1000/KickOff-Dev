import 'package:firebase_database/firebase_database.dart';

import '../../domain/entities/Stadium.dart';
import '../../domain/repositories/IStadiumRepository.dart';
import '../../infrastructure/firebase/FirebaseService.dart';

class StadiumRepository implements IStadiumRepository {
  final String _collectionPath = 'stadiums';
  final FirebaseService _firebaseService;

  StadiumRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  @override
  Future<void> addStadium(Stadium stadium) async {
    try {
      await _firebaseService.setDocument(
          '$_collectionPath/${stadium.stadiumId}', stadium.toJson());
    } catch (e) {
      throw Exception('Failed to add stadium: $e');
    }
  }

  @override
  Future<Stadium> getStadiumById(String stadiumId) async {
    try {
      DataSnapshot snapshot =
      await _firebaseService.getDocument('$_collectionPath/$stadiumId');
      if (snapshot.exists && snapshot.value != null) {
        var stadiumData = snapshot.value as Map;
        return Stadium.fromJson(Map<String, dynamic>.from(stadiumData));
      } else {
        throw Exception('Stadium not found for ID $stadiumId');
      }
    } catch (e) {
      throw Exception('Error fetching stadium by ID $stadiumId: $e');
    }
  }

  @override
  Future<void> updateStadium(Stadium stadium) async {
    try {
      await _firebaseService.updateDocument(
          '$_collectionPath/${stadium.stadiumId}', stadium.toJson());
    } catch (e) {
      throw Exception('Failed to update stadium: $e');
    }
  }

  @override
  Future<void> deleteStadium(String stadiumId) async {
    try {
      await _firebaseService.deleteDocument('$_collectionPath/$stadiumId');
    } catch (e) {
      throw Exception('Failed to delete stadium: $e');
    }
  }

  @override
  Future<List<Stadium>> getAllStadiums() async {
    try {
      DataSnapshot snapshot =
      await _firebaseService.getDocument(_collectionPath);
      if (snapshot.exists && snapshot.value != null) {
        var stadiumsMap = snapshot.value as Map<dynamic, dynamic>;
        return stadiumsMap.entries
            .map((e) => Stadium.fromJson(
            Map<String, dynamic>.from(e.value as Map)
              ..['stadiumId'] = e.key))
            .toList();
      }
      return []; // Return an empty list if no stadiums found
    } catch (e) {
      print('Failed to retrieve all stadiums: $e');
      throw Exception('Failed to retrieve all stadiums');
    }
  }
}
