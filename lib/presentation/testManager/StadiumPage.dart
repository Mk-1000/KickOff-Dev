import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:takwira/business/services/ImageService.dart';
import 'package:takwira/business/services/StadiumService.dart';
import 'package:takwira/domain/entities/Address.dart';
import 'package:takwira/domain/entities/Field.dart';
import 'package:takwira/domain/entities/Stadium.dart';
import 'package:takwira/domain/services/IImageService.dart';

import '../../domain/repositories/IImageRepository.dart';

class AddStadiumScreen extends StatefulWidget {
  @override
  _AddStadiumScreenState createState() => _AddStadiumScreenState();
}

class _AddStadiumScreenState extends State<AddStadiumScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _servicesController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController();
  DateTime? _startAt;
  DateTime? _closeAt;
  File? selectedMainImage;
  List<File?> _selectedFieldImages =
      []; // List to hold selected images for fields
  final IImageService _imageService = ImageService();
  List<Field> _fields = []; // List to hold the fields

  Future<void> _pickDateTime(BuildContext context, DateTime initialDate,
      Function(DateTime) onConfirm) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (pickedTime != null) {
        final pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        onConfirm(pickedDateTime);
      }
    }
  }

  Future<void> _selectImageForField(int fieldIndex) async {
    File? image = await _imageService.selectImage();
    if (image != null) {
      setState(() {
        _selectedFieldImages[fieldIndex] = image;
      });
    }
  }

  Future<String?> _uploadImageAndSetUrl(String stadiumId) async {
    if (selectedMainImage != null) {
      String imageUrl = await _imageService.uploadImageWithType(
          selectedMainImage!, UploadType.Stadium, stadiumId);
      // Assuming _imageService.uploadImageWithType returns the URL
      return imageUrl;
    }
    return null;
  }

  void _addNewField() {
    setState(() {
      _fields.add(Field(capacity: 0, matchPrice: 0.0));
      _selectedFieldImages.add(null);
    });
  }

  void _removeField(int index) {
    setState(() {
      _fields.removeAt(index);
      _selectedFieldImages.removeAt(index);
    });
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final address = Address(
        addressType: AddressType.StadiumAddress,
        street: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        postalCode: _postalCodeController.text,
        country: _countryController.text.isNotEmpty
            ? _countryController.text
            : 'Tunisie',
      );

      final stadium = Stadium(
        name: _nameController.text,
        address: address,
        phoneNumber: _phoneNumberController.text,
        services:
            _servicesController.text.split(',').map((s) => s.trim()).toList(),
        startAt: _startAt!,
        closeAt: _closeAt!,
        fields: _fields, // Assign the list of fields
      );
      String? imageUrl = await _uploadImageAndSetUrl(stadium.stadiumId);
      if (imageUrl != null) {
        stadium.mainImage = imageUrl;
      }

      // Upload images for each field
      for (int i = 0; i < _fields.length; i++) {
        if (_selectedFieldImages[i] != null) {
          String imageUrl = await _imageService.uploadImageWithType(
              _selectedFieldImages[i]!, UploadType.Stadium, _fields[i].fieldId);
          _fields[i].images.add(imageUrl);
        }
      }

      await StadiumService().createStadium(stadium);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Stadium added successfully!')),
      );

      _formKey.currentState?.reset();
      _clearControllers();
    }
  }

  void _clearControllers() {
    _nameController.clear();
    _phoneNumberController.clear();
    _servicesController.clear();
    _streetController.clear();
    _cityController.clear();
    _stateController.clear();
    _postalCodeController.clear();
    _countryController.clear();
    setState(() {
      _startAt = null;
      _closeAt = null;
      selectedMainImage = null;
      _fields.clear(); // Clear the fields list
      _selectedFieldImages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Stadium'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the stadium name';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: selectedMainImage != null
                        ? Image.file(selectedMainImage!)
                        : Container(),
                  ),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: _selectImage,
                  ),
                ],
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _servicesController,
                decoration:
                    InputDecoration(labelText: 'Services (comma-separated)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the services';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(labelText: 'Street'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the street';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the city';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'State'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the state';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _postalCodeController,
                decoration: InputDecoration(labelText: 'Postal Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the postal code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country'),
              ),
              ListTile(
                title: Text(_startAt == null
                    ? 'Select Start Time'
                    : 'Start Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(_startAt!)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDateTime(context, _startAt ?? DateTime.now(),
                    (DateTime dateTime) {
                  setState(() {
                    _startAt = dateTime;
                  });
                }),
              ),
              ListTile(
                title: Text(_closeAt == null
                    ? 'Select Close Time'
                    : 'Close Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(_closeAt!)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDateTime(context, _closeAt ?? DateTime.now(),
                    (DateTime dateTime) {
                  setState(() {
                    _closeAt = dateTime;
                  });
                }),
              ),
              ElevatedButton(
                onPressed: _addNewField,
                child: Text('Add Field'),
              ),
              ..._fields.asMap().entries.map((entry) {
                int index = entry.key;
                Field field = entry.value;
                return Column(
                  children: [
                    Text('Field ${index + 1}'),
                    Row(
                      children: [
                        Expanded(
                          child: _selectedFieldImages[index] != null
                              ? Image.file(_selectedFieldImages[index]!)
                              : Container(),
                        ),
                        IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () => _selectImageForField(index),
                        ),
                      ],
                    ),
                    TextFormField(
                      initialValue: field.capacity.toString(),
                      decoration: InputDecoration(labelText: 'Capacity'),
                      onChanged: (value) {
                        setState(() {
                          field.capacity = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: field.matchPrice.toString(),
                      decoration: InputDecoration(labelText: 'Match Price'),
                      onChanged: (value) {
                        setState(() {
                          field.matchPrice = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () => _removeField(index),
                      child: Text('Remove Field'),
                    ),
                  ],
                );
              }),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    File? image = await _imageService.selectImage();
    if (image != null) {
      setState(() {
        selectedMainImage = image;
      });
    }
  }
}

class IDUtils {
  static String generateUniqueId() {
    throw UnimplementedError();
  }
}
