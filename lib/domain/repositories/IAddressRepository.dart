import '../entities/Address.dart';

abstract class IAddressRepository {
  Future<void> addAddress(Address address);
  Future<Address> getAddressById(String addressId);
  Future<List<Address>> getAddressesByUserId(String userId);
  Future<void> updateAddress(Address address);
  Future<void> deleteAddress(String addressId);
}
