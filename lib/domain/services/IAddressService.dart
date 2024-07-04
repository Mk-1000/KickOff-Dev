import '../entities/Address.dart';

abstract class IAddressService {
  Future<void> addAddress(Address address);
  Future<Address> getAddressDetails(String addressId);
  Future<void> updateAddress(Address address);
  Future<List<Address>> getAddressesByUserId(String userId);
  Future<void> deleteAddress(String addressId);
}
