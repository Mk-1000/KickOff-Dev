import 'dart:io';

abstract class IImageService {
  Future<String> uploadImage(File image, String path);
  Future<void> deleteImage(String imageUrl);
  Future<File?> selectImage();
  Future<List<String>> fetchUploadedImages();
}
