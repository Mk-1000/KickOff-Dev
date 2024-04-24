import '../entities/Address.dart';

abstract class IAddressRepository {
  Future<List<Address>> getAllAddresses();
  Future<Address> getAddressById(String id);
  Future<void> addAddress(Address address);
  Future<void> updateAddress(Address address);
  Future<void> deleteAddress(String id);
}
