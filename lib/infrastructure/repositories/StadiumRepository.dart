import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Stadium.dart';
import '../../domain/repositories/IStadiumRepository.dart';
import '../firebase/FirebaseService.dart';

class StadiumRepository implements IStadiumRepository {
  final String _collectionPath = 'stadiums';
  final FirebaseService _firebaseService; // Instance field for FirebaseService

  StadiumRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  // @override
  // Future<List<Stadium>> getAllStadiums() async {
  //   DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
  //   if (snapshot.exists && snapshot.value != null) {
  //     Map<dynamic, dynamic> stadiumsMap =
  //         (snapshot.value as Map).cast<dynamic, dynamic>();
  //     return stadiumsMap.values
  //         .map((e) => Stadium.fromJson(Map<String, dynamic>.from(e as Map)))
  //         .toList();
  //   }
  //   return [];
  // }

  @override
  Future<List<Stadium>> getAllStadiums() async {
    // Use Stream to listen for changes in real-time
    final Stream<DatabaseEvent> stream =
        _firebaseService.getCollectionStream(_collectionPath);

    // Handle initial data and subsequent updates
    final stadiums = <Stadium>[];
    stream.listen((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          stadiums.add(Stadium.fromJson(Map<String, dynamic>.from(value)));
        });
      }
    });

    return stadiums; // Return the initially loaded stadiums
  }

  @override
  Future<Stadium> getStadiumById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists && snapshot.value != null) {
      return Stadium.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    }
    throw Exception('Stadium not found');
  }

  @override
  Future<void> addStadium(Stadium stadium) async {
    await _firebaseService.setDocument(_collectionPath, stadium.toJson());
  }

  @override
  Future<void> updateStadium(Stadium stadium) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${stadium.stadiumId}', stadium.toJson());
  }

  @override
  Future<void> deleteStadium(String id) async {
    await _firebaseService.deleteDocument('$_collectionPath/$id');
  }
}
