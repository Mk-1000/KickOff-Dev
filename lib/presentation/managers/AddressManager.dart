import 'package:takwira/domain/entities/Address.dart';
import 'package:takwira/business/services/address_service.dart';

class AddressManager {
  final AddressService _addressService = AddressService();

  List<Address> _addresses = [];
  Address? _currentAddress;

  List<Address> get addresses => _addresses;
  Address? get currentAddress => _currentAddress;

  Future<void> loadAddressesByUserId(String userId) async {
    _addresses = await _addressService.getAddressesByUserId(userId);
    // No notifyListeners() - You will need to handle UI updates manually
  }

  Future<void> loadAddressDetails(String addressId) async {
    _currentAddress = await _addressService.getAddressDetails(addressId);
    // Manual UI updates as needed
  }

  Future<void> addAddress(Address address) async {
    await _addressService.addAddress(address);
    _addresses.add(address);
    // Update UI manually if needed
  }

  Future<void> updateAddress(Address address) async {
    await _addressService.updateAddress(address);
    int index = _addresses.indexWhere((a) => a.addressId == address.addressId);
    if (index != -1) {
      _addresses[index] = address;
      // Manually update UI if necessary
    }
  }

  Future<void> deleteAddress(String addressId) async {
    await _addressService.deleteAddress(addressId);
    _addresses.removeWhere((address) => address.addressId == addressId);
    // Handle UI updates manually
  }
}
