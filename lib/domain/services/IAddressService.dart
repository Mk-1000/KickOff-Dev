import '../entities/Address.dart';

abstract class IAddressService {
  Future<void> createAddress(Address address);
  Future<Address> getAddressDetails(String addressId);
  Future<List<Address>> getAddressesByUser(String userId);
  Future<void> updateAddress(Address address);
  Future<void> deleteAddress(String addressId);
}
