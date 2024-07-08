import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:takwira/business/services/ImageService.dart';
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
  List<Field> _fields = [];
  final IImageService _imageService = ImageService();

  @override
  void initState() {
    super.initState();
    _fields.add(Field(capacity: 0, matchPrice: 0.0)); // Initial field
  }

  Future<void> _selectImageForMain() async {
    File? image = await _imageService.selectImage();
    if (image != null) {
      setState(() {
        selectedMainImage = image;
      });
    }
  }

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
        _fields[fieldIndex].images.add(image.path); // Store image path
      });
    }
  }

  Future<String?> _uploadImageAndSetUrl(String stadiumId) async {
    if (selectedMainImage != null) {
      String imageUrl = await _imageService.uploadImageWithType(
          selectedMainImage!, UploadType.Stadium, stadiumId);
      return imageUrl;
    }
    return null;
  }

  void _addNewField() {
    setState(() {
      _fields.add(Field(capacity: 0, matchPrice: 0.0));
    });
  }

  void _removeField(int index) {
    setState(() {
      _fields.removeAt(index);
    });
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final address = Address(
        street: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        postalCode: _postalCodeController.text,
        country: _countryController.text.isNotEmpty
            ? _countryController.text
            : 'Tunisie',
        addressType: AddressType.StadiumAddress,
      );

      final stadium = Stadium(
        name: _nameController.text,
        address: address,
        phoneNumber: _phoneNumberController.text,
        services:
            _servicesController.text.split(',').map((s) => s.trim()).toList(),
        startAt: _startAt!,
        closeAt: _closeAt!,
        fields: _fields,
      );
      String? imageUrl = await _uploadImageAndSetUrl(stadium.stadiumId);
      if (imageUrl != null) {
        stadium.mainImage = imageUrl;
      }

      // Simulate API call to save stadium
      await Future.delayed(Duration(seconds: 1));

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
                decoration: InputDecoration(labelText: 'Stadium Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the stadium name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _selectImageForMain,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: selectedMainImage != null
                      ? Image.file(
                          selectedMainImage!,
                          fit: BoxFit.cover,
                        )
                      : Center(child: Icon(Icons.image)),
                ),
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(labelText: 'Street Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the street address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'State/Province'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the state/province';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country'),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text(_startAt == null
                    ? 'Select Opening Time'
                    : 'Opening Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(_startAt!)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDateTime(context, _startAt ?? DateTime.now(),
                    (DateTime dateTime) {
                  setState(() {
                    _startAt = dateTime;
                  });
                }),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text(_closeAt == null
                    ? 'Select Closing Time'
                    : 'Closing Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(_closeAt!)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDateTime(context, _closeAt ?? DateTime.now(),
                    (DateTime dateTime) {
                  setState(() {
                    _closeAt = dateTime;
                  });
                }),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addNewField,
                child: Text('Add Field'),
              ),
              SizedBox(height: 16),
              ..._fields.asMap().entries.map((entry) {
                int index = entry.key;
                Field field = entry.value;
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Field ${index + 1}'),
                        SizedBox(height: 8),
                        TextFormField(
                          initialValue: field.capacity.toString(),
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Capacity of field'),
                          onChanged: (value) {
                            setState(() {
                              _fields[index].capacity = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          initialValue: field.matchPrice.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Match price'),
                          onChanged: (value) {
                            setState(() {
                              _fields[index].matchPrice = double.parse(value);
                            });
                          },
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _selectImageForField(index),
                          child: Text('Select Image for Field'),
                        ),
                        SizedBox(height: 8),
                        ...field.images.map((imagePath) {
                          return Image.file(
                            File(imagePath),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          );
                        }),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () => _removeField(index),
                            child: Text('Remove Field'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Stadium'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
