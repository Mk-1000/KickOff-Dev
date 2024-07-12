import 'dart:io';

import 'package:flutter/material.dart';

import '../../business/services/AddressService.dart';
import '../../business/services/ImageService.dart';
import '../../business/services/StadiumService.dart';
import '../../domain/entities/Address.dart';
import '../../domain/entities/Field.dart';
import '../../domain/entities/Stadium.dart';
import '../../domain/repositories/IImageRepository.dart';
import '../../utils/TunisiaLocations.dart';

class AddStadiumScreen extends StatefulWidget {
  @override
  _AddStadiumScreenState createState() => _AddStadiumScreenState();
}

class _AddStadiumScreenState extends State<AddStadiumScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _servicesController = TextEditingController();
  TimeOfDay? _startAt;
  TimeOfDay? _closeAt;
  File? selectedMainImage;
  List<Field> _fields = [];
  Stadium? currentStadium; // Updated to use Stadium type directly
  final ImageService _imageService =
      ImageService(); // Your image service implementation
  final StadiumService _stadiumService =
      StadiumService(); // Your stadium service implementation
  String? selectedState;
  String? selectedCity;
  List<String> cities = [];
  final _mapLink = TextEditingController();
  final _street = TextEditingController();
  final _postalCode = TextEditingController();
  final _latitude = TextEditingController();
  final _longitude = TextEditingController();
  @override
  void initState() {
    super.initState();
    currentStadium = Stadium(name: '', phoneNumber: '', services: []);
  }

  Future<void> _selectImageForMain() async {
    File? image = await _imageService.selectImage();
    if (image != null) {
      setState(() {
        selectedMainImage = image;
      });
    }
  }

  Future<void> _pickTime(BuildContext context, TimeOfDay initialTime,
      Function(TimeOfDay) onConfirm) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      onConfirm(pickedTime);
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

  Future<String?> _uploadImageAndSetUrl(File image, String path) async {
    if (image != null) {
      String imageUrl = await _imageService.uploadImageWithType(
          image, UploadType.Stadium, path);
      return imageUrl;
    }
    return null;
  }

  Future<List<String>> _uploadImagesAndSetUrls(
      List<File> images, String stadiumId, String fieldId) async {
    List<String> imageUrls = [];
    for (File image in images) {
      String path = '$stadiumId/$fieldId/images';
      String? imageUrl = await _uploadImageAndSetUrl(image, path);
      if (imageUrl != null) {
        imageUrls.add(imageUrl);
      }
    }
    return imageUrls;
  }

  void _addNewField() {
    setState(() {
      _fields.add(Field(capacity: 0, matchPrice: 0.0, images: []));
    });
  }

  void _removeField(int index) {
    setState(() {
      _fields.removeAt(index);
    });
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      currentStadium!.name = _nameController.text;
      currentStadium!.phoneNumber = _phoneNumberController.text;
      currentStadium!.services =
          _servicesController.text.split(',').map((s) => s.trim()).toList();
      currentStadium!.startAt =
          DateTime(2000, 1, 1, _startAt!.hour, _startAt!.minute);
      currentStadium!.closeAt =
          DateTime(2000, 1, 1, _closeAt!.hour, _closeAt!.minute);

      // create staduim address
      Address address = Address(
          addressType: AddressType.StadiumAddress,
          city: selectedCity!,
          state: selectedState!,
          street: _street.text,
          postalCode: _postalCode.text,
          latitude: double.parse(_latitude.text),
          longitude: double.parse(_longitude.text),
          link: _mapLink.text);

      await AddressService().createAddress(address);
      currentStadium!.address = address.addressId;

      // Upload main image
      String stadiumId = currentStadium!.stadiumId;
      String mainImagePath = '$stadiumId/mainImage';
      String? mainImageUrl =
          await _uploadImageAndSetUrl(selectedMainImage!, mainImagePath);
      if (mainImageUrl != null) {
        currentStadium!.mainImage = mainImageUrl;
      }

      // Upload field images
      for (int i = 0; i < _fields.length; i++) {
        List<String> fieldImageUrls = await _uploadImagesAndSetUrls(
          _fields[i].images.map((path) => File(path)).toList(),
          stadiumId,
          _fields[i].fieldId,
        );
        _fields[i].images = fieldImageUrls;
      }

      // Simulate API call to save stadium
      await Future.delayed(Duration(seconds: 1));

      currentStadium?.fields = _fields;
      _stadiumService.createStadium(currentStadium!);

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
    _mapLink.clear();
    _street.clear();
    _postalCode.clear();
    _latitude.clear();
    _longitude.clear();

    setState(() {
      _startAt = null;
      _closeAt = null;
      selectedMainImage = null;
      _fields.clear(); // Clear the fields list
      currentStadium = Stadium(
          name: '', phoneNumber: '', services: []); // Reset currentStadium
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    hint: Text("Select State"),
                    value: selectedState,
                    items: TunisiaLocations.states.map((String state) {
                      return DropdownMenuItem<String>(
                        value: state,
                        child: Text(state),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedState = newValue;
                        selectedCity = null; // Reset city selection
                        cities =
                            TunisiaLocations.citiesBystates[newValue!] ?? [];
                      });
                    },
                  ),
                  if (cities.isNotEmpty)
                    DropdownButton<String>(
                      hint: Text("Select City"),
                      value: selectedCity,
                      items: cities.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedCity = newValue;
                        });
                      },
                    ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _mapLink,
                decoration: InputDecoration(labelText: 'Map Link'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the map link';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _street,
                decoration: InputDecoration(labelText: 'Street'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the street';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _postalCode,
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
                controller: _latitude,
                decoration: InputDecoration(labelText: 'Latitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the latitude';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _longitude,
                decoration: InputDecoration(labelText: 'Longitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the longitude';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text(_startAt == null
                    ? 'Select Start Time'
                    : 'Start Time: ${_startAt!.format(context)}'),
                trailing: Icon(Icons.access_time),
                onTap: () => _pickTime(
                  context,
                  _startAt ?? TimeOfDay.now(),
                  (pickedTime) {
                    setState(() {
                      _startAt = pickedTime;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text(_closeAt == null
                    ? 'Select Close Time'
                    : 'Close Time: ${_closeAt!.format(context)}'),
                trailing: Icon(Icons.access_time),
                onTap: () => _pickTime(
                  context,
                  _closeAt ?? TimeOfDay.now(),
                  (pickedTime) {
                    setState(() {
                      _closeAt = pickedTime;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _fields.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Field ${index + 1}'),
                          SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Capacity'),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              _fields[index].capacity = int.parse(value);
                            },
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Match Price'),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              _fields[index].matchPrice = double.parse(value);
                            },
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => _selectImageForField(index),
                            child: Text('Select Field Images'),
                          ),
                          SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: _fields[index].images.length,
                            itemBuilder: (context, imgIndex) {
                              return Image.file(
                                File(_fields[index].images[imgIndex]),
                                height: 100,
                              );
                            },
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => _removeField(index),
                            child: Text('Remove Field'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addNewField,
                child: Text('Add New Field'),
              ),
              SizedBox(height: 16),
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
}
