import 'dart:io';

import 'package:flutter/material.dart';
import 'package:takwira/business/services/ImageService.dart';
import 'package:takwira/domain/repositories/IImageRepository.dart';

class UploadManagerScreen extends StatefulWidget {
  const UploadManagerScreen({super.key});

  @override
  _UploadManagerScreenState createState() => _UploadManagerScreenState();
}

class _UploadManagerScreenState extends State<UploadManagerScreen> {
  final ImageService _imageService = ImageService();
  UploadType? _selectedUploadType;
  List<String> _uploadedImageUrls = [];
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _loadUploadedImages();
  }

  Future<void> _loadUploadedImages() async {
    try {
      List<String> imageUrls = await _imageService.fetchUploadedImages();
      setState(() {
        _uploadedImageUrls = imageUrls;
      });
    } catch (e) {
      print('Error loading images: $e');
      _showDialog('Error', 'Failed to load images: $e');
    }
  }

  void _selectUploadType(UploadType type) {
    setState(() {
      _selectedUploadType = type;
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _showDialog(String title, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickAndUploadImage() async {
    if (_selectedUploadType == null) {
      _showSnackbar('Please select an upload type.');
      return;
    }

    File? image = await _imageService.selectImage();
    if (image != null) {
      setState(() {
        _isUploading = true;
      });
      try {
        String imageUrl = await _imageService.uploadImageWithType(
            image, _selectedUploadType!, "zdaezaeazeaze");
        setState(() {
          _uploadedImageUrls.add(imageUrl);
        });
        _showSnackbar('Image uploaded successfully.');
      } catch (e) {
        _showDialog('Error', 'Failed to upload image: $e');
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Widget _buildUploadButton(UploadType type, String label) {
    return ElevatedButton(
      onPressed: () => _selectUploadType(type),
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedUploadType == type ? Colors.blueAccent : null,
      ),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildUploadButton(
                UploadType.CustomTeam, 'Upload Custom Team Image'),
            _buildUploadButton(
                UploadType.TeamTunisien, 'Upload Team Tunisien Image'),
            _buildUploadButton(UploadType.League, 'Upload League Image'),
            _buildUploadButton(UploadType.Player, 'Upload Player Image'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading ? null : _pickAndUploadImage,
              child: _isUploading
                  ? const CircularProgressIndicator()
                  : const Text('Pick and Upload Image'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Uploaded Images:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _uploadedImageUrls.isEmpty
                  ? const Center(child: Text('No images uploaded yet.'))
                  : ListView.builder(
                      itemCount: _uploadedImageUrls.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Image.network(
                              _uploadedImageUrls[index],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(_uploadedImageUrls[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await _imageService
                                    .deleteImage(_uploadedImageUrls[index]);
                                setState(() {
                                  _uploadedImageUrls.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
