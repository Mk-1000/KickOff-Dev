import 'package:takwira/business/services/AddressService.dart';
import 'package:takwira/domain/entities/Address.dart';
import 'package:takwira/domain/services/IAddressService.dart';

class AddressManager {
  final IAddressService _addressService = AddressService();

  Future<Address> getAddressDetails(String addressId) async {
    return await _addressService.getAddressDetails(addressId);
  }

  Future<bool> createAddress(Address address) async {
    try {
      await _addressService.createAddress(address);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> updateAddress(Address address) async {
    try {
      await _addressService.updateAddress(address);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> deleteAddress(String addressId) async {
    try {
      await _addressService.deleteAddress(addressId);
      return true;
    } on Exception {
      return false;
    }
  }
}
