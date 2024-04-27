import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Address.dart';
import '../Managers/AddressManager.dart';

class AddressForm extends StatefulWidget {
  AddressForm({Key? key}) : super(key: key);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController();
  final _userIdController = TextEditingController();

  late AddressManager addressManager;

  @override
  void initState() {
    super.initState();
    // Instantiate the AddressManager
    addressManager = AddressManager();
  }

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newAddress = Address(
        addressId:
            DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
        street: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        postalCode: _postalCodeController.text,
        country: _countryController.text,
        latitude:
            0.0, // Assuming latitude and longitude are not needed for input
        longitude: 0.0,
        userId: _userIdController.text,
      );

      await addressManager.addAddress(newAddress);
      setState(() {}); // Refresh the list after adding a new address
    }
  }

  Widget _buildAddressList() {
    return Expanded(
      child: ListView.builder(
        itemCount: addressManager.addresses.length,
        itemBuilder: (context, index) {
          var address = addressManager.addresses[index];
          return ListTile(
            title: Text(address.street),
            subtitle:
                Text('${address.city}, ${address.state}, ${address.country}'),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Addresses")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // TextFormFields as previously defined
                    TextFormField(
                        controller: _streetController,
                        decoration: InputDecoration(labelText: 'Street')),
                    TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(labelText: 'City')),
                    TextFormField(
                        controller: _stateController,
                        decoration: InputDecoration(labelText: 'State')),
                    TextFormField(
                        controller: _postalCodeController,
                        decoration: InputDecoration(labelText: 'Postal Code')),
                    TextFormField(
                        controller: _countryController,
                        decoration: InputDecoration(labelText: 'Country')),
                    TextFormField(
                        controller: _userIdController,
                        decoration: InputDecoration(labelText: 'User ID')),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildAddressList(), // Call to build the address list
        ],
      ),
    );
  }
}
