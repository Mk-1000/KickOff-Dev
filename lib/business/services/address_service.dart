import 'package:takwira/domain/services/iaddress_service.dart';
import '../../domain/entities/Address.dart';
import '../../domain/repositories/IAddressRepository.dart';

class AddressService implements IAddressService {
  final IAddressRepository _addressRepository;

  AddressService(this._addressRepository);

  @override
  Future<List<Address>> getAddressesByUserId(String userId) async {
    // Delegate to the repository with any userId logic (if applicable)
    final addresses = await _addressRepository.getAllAddresses();
    // Filter addresses by userId if needed (assuming a 'userId' field)
    return addresses.where((address) => address.userId == userId).toList();
  }

  @override
  Future<Address> getAddressDetails(String addressId) async {
    return await _addressRepository.getAddressById(addressId);
  }

  @override
  Future<void> addAddress(Address address) async {
    // Consider adding userId to the address object before saving
    await _addressRepository.addAddress(address);
  }

  @override
  Future<void> updateAddress(Address address) async {
    await _addressRepository.updateAddress(address);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await _addressRepository.deleteAddress(addressId);
  }
}
