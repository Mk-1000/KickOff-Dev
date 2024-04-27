import 'package:flutter/material.dart';
import '../Managers/AddressManager.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddressScreenState createState() => _AddressScreenState();
}

late AddressManager addressManager;

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();
    addressManager = AddressManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Addresses"),
      ),
      body: ListView.builder(
        itemCount: addressManager.addresses.length,
        itemBuilder: (context, index) {
          var address = addressManager.addresses[index];
          return ListTile(
            title: Text(address.street),
            subtitle: Text(address.city),
            onTap: () async {
              await addressManager.loadAddressDetails(address.addressId);
              setState(() {}); // Refresh UI to show address details if needed
            },
          );
        },
      ),
    );
  }
}
