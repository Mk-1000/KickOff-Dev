import 'dart:io';

enum UploadType {
  CustomTeam,
  TeamTunisien,
  League,
  Player,
}

abstract class IImageRepository {
  Future<String> uploadImage(File image, String path);
  Future<void> deleteImage(String imageUrl);
  Future<String> uploadImageWithType(File image, UploadType uploadType);
  Future<List<String>> fetchUploadedImages();
}
