import 'package:takwira/domain/entities/Address.dart';
import 'package:takwira/domain/repositories/IAddressRepository.dart';
import 'package:takwira/infrastructure/repositories/AddressRepository.dart'; // Import the AddressRepository class

import '../../domain/services/IAddressService.dart';

class AddressService implements IAddressService {
  final IAddressRepository _addressRepository;

  AddressService({IAddressRepository? addressRepository})
      : _addressRepository = addressRepository ?? AddressRepository();

  @override
  Future<void> createAddress(Address address) async {
    try {
      await _addressRepository.addAddress(address);
    } catch (e) {
      throw Exception('Failed to create address: $e');
    }
  }

  @override
  Future<Address> getAddressDetails(String addressId) async {
    try {
      return await _addressRepository.getAddressById(addressId);
    } catch (e) {
      throw Exception('Failed to get address details: $e');
    }
  }

  @override
  Future<List<Address>> getAddressesByUser(String userId) async {
    try {
      return await _addressRepository.getAddressesByUserId(userId);
    } catch (e) {
      throw Exception('Failed to get addresses by user: $e');
    }
  }

  @override
  Future<void> updateAddress(Address address) async {
    try {
      await _addressRepository.updateAddress(address);
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    try {
      await _addressRepository.deleteAddress(addressId);
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }
}
