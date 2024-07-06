import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:takwira/domain/repositories/IImageRepository.dart';
import 'package:takwira/domain/services/IImageService.dart';
import 'package:takwira/infrastructure/repositories/ImageRepository.dart';

class ImageService implements IImageService {
  final IImageRepository _imageRepository;

  ImageService({IImageRepository? imageRepository})
      : _imageRepository = imageRepository ?? ImageRepository();

  @override
  Future<String> uploadImage(File image, String path) async {
    return await _imageRepository.uploadImage(image, path);
  }

  Future<String> uploadImageWithType(File image, UploadType uploadType) async {
    return await _imageRepository.uploadImageWithType(image, uploadType);
  }

  @override
  Future<void> deleteImage(String imageUrl) async {
    await _imageRepository.deleteImage(imageUrl);
  }

  @override
  Future<File?> selectImage() async {
    ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  @override
  Future<List<String>> fetchUploadedImages() async {
    return await _imageRepository.fetchUploadedImages();
  }
}
