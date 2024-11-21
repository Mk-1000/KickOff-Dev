import 'dart:io';

import '../repositories/IImageRepository.dart';

abstract class IImageService {
  Future<String> uploadImage(File image, String path);
  Future<void> deleteImage(String imageUrl);
  Future<File?> selectImage();
  Future<List<String>> fetchUploadedImages();
  uploadImageWithType(File image, UploadType uploadType, String referenceId);
}
