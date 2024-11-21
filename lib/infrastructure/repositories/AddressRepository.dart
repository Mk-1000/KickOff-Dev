import 'package:firebase_database/firebase_database.dart';
import 'package:takwira/domain/entities/Address.dart';
import 'package:takwira/domain/repositories/IAddressRepository.dart';
import 'package:takwira/infrastructure/firebase/FirebaseService.dart';

class AddressRepository implements IAddressRepository {
  final String _collectionPath = 'addresses';
  final FirebaseService _firebaseService;

  AddressRepository({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  @override
  Future<void> addAddress(Address address) async {
    try {
      await _firebaseService.setDocument(
          '$_collectionPath/${address.addressId}', address.toJson());
    } catch (e) {
      throw Exception('Failed to add address: $e');
    }
  }

  @override
  Future<Address> getAddressById(String addressId) async {
    try {
      DataSnapshot snapshot =
          await _firebaseService.getDocument('$_collectionPath/$addressId');
      if (snapshot.exists && snapshot.value != null) {
        var addressData = snapshot.value as Map;
        return Address.fromJson(Map<String, dynamic>.from(addressData));
      } else {
        throw Exception('Address not found for ID $addressId');
      }
    } catch (e) {
      throw Exception('Error fetching address by ID $addressId: $e');
    }
  }

  @override
  Future<List<Address>> getAddressesByUserId(String userId) async {
    try {
      final query =
          _firebaseService.getCollectionStream(_collectionPath).map((event) {
        return (event.snapshot.value as Map<dynamic, dynamic>)
            .values
            .where(
                (value) => (value as Map<dynamic, dynamic>)['userId'] == userId)
            .map((value) => Address.fromJson(
                Map<String, dynamic>.from(value as Map<dynamic, dynamic>)))
            .toList();
      });
      final List<Address> addresses = await query.first;
      return addresses;
    } catch (e) {
      throw Exception('Failed to retrieve addresses by user $userId');
    }
  }

  @override
  Future<void> updateAddress(Address address) async {
    try {
      await _firebaseService.updateDocument(
          '$_collectionPath/${address.addressId}', address.toJson());
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    try {
      await _firebaseService.deleteDocument('$_collectionPath/$addressId');
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }
}
