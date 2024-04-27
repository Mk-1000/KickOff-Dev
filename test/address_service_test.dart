import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:takwira/domain/entities/Address.dart';
import 'package:takwira/business/services/Address_service.dart';
import 'Mocks/address/i_address_repository_test.mocks.dart';

void main() {
  group('Address Service Tests', () {
    late AddressService addressService;
    late MockIAddressRepository mockAddressRepository;
    late Address testAddress;

    setUp(() {
      mockAddressRepository = MockIAddressRepository();
      addressService = AddressService(addressRepository: mockAddressRepository);
      testAddress = Address(
        addressId: '1',
        street: '123 Test St',
        city: 'TestCity',
        state: 'TestState',
        postalCode: '12345',
        country: 'TestCountry',
        latitude: 34.0,
        longitude: -118.0,
        userId: 'user-123',
      );

      // Set up mock responses for your repository
      when(mockAddressRepository.addAddress(any)).thenAnswer((_) async => {});
      when(mockAddressRepository.getAddressById(any))
          .thenAnswer((_) async => testAddress);
      when(mockAddressRepository.getAllAddresses())
          .thenAnswer((_) async => [testAddress]);
      when(mockAddressRepository.updateAddress(any))
          .thenAnswer((_) async => {});
      when(mockAddressRepository.deleteAddress(any))
          .thenAnswer((_) async => {});
    });

    test('Add Address', () async {
      await addressService.addAddress(testAddress);
      verify(mockAddressRepository.addAddress(testAddress)).called(1);
    });

    test('Get Address Details', () async {
      final result = await addressService.getAddressDetails('1');
      expect(result, equals(testAddress));
      verify(mockAddressRepository.getAddressById('1')).called(1);
    });

    test('Get Addresses By User ID', () async {
      final result = await addressService.getAddressesByUserId('user-123');
      expect(result, contains(testAddress));
      verify(mockAddressRepository.getAllAddresses()).called(1);
    });

    test('Update Address', () async {
      await addressService.updateAddress(testAddress);
      verify(mockAddressRepository.updateAddress(testAddress)).called(1);
    });

    test('Delete Address', () async {
      await addressService.deleteAddress('1');
      verify(mockAddressRepository.deleteAddress('1')).called(1);
    });
  });
}
