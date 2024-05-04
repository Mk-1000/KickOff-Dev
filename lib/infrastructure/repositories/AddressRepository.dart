import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/Address.dart';
import '../../domain/repositories/IAddressRepository.dart';
import '../firebase/FirebaseService.dart';

class AddressRepository implements IAddressRepository {
  final String _collectionPath = 'addresses';
  final FirebaseService _firebaseService; // Instance field for FirebaseService

  AddressRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  // using getDocument
  // @override
  // Future<List<Address>> getAllAddresses() async {
  //   DataSnapshot snapshot = await _firebaseService.getDocument(_collectionPath);
  //   if (snapshot.exists) {
  //     Map<dynamic, dynamic> addresses = snapshot.value as Map<dynamic, dynamic>;
  //     return addresses.values
  //         .map((e) => Address.fromJson(Map<String, dynamic>.from(e)))
  //         .toList();
  //   }
  //   return [];
  // }

  @override
  Future<List<Address>> getAllAddresses() async {
    // Use Stream to listen for changes in real-time
    final Stream<DatabaseEvent> stream =
        _firebaseService.getCollectionStream(_collectionPath);

    // Handle initial data and subsequent updates
    final addresses = <Address>[];
    stream.listen((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          addresses.add(Address.fromJson(Map<String, dynamic>.from(value)));
        });
      }
    });

    return addresses; // Return the initially loaded addresses
  }

  @override
  Future<Address> getAddressById(String id) async {
    DataSnapshot snapshot =
        await _firebaseService.getDocument('$_collectionPath/$id');
    if (snapshot.exists) {
      return Address.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    }
    throw Exception('Address not found');
  }

  @override
  Future<void> addAddress(Address address) async {
    await _firebaseService.setDocument(_collectionPath, address.toJson());
  }

  @override
  Future<void> updateAddress(Address address) async {
    await _firebaseService.updateDocument(
        '$_collectionPath/${address.addressId}', address.toJson());
  }

  @override
  Future<void> deleteAddress(String id) async {
    await _firebaseService.deleteDocument('$_collectionPath/$id');
  }
}
