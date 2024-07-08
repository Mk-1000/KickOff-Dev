import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:takwira/domain/repositories/IImageRepository.dart';

class ImageRepository implements IImageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String _getPathForUploadType(UploadType uploadType) {
    switch (uploadType) {
      case UploadType.CustomTeam:
        return 'images/custom_team';
      case UploadType.TeamTunisien:
        return 'images/team_tunisien';
      case UploadType.League:
        return 'images/league';
      case UploadType.Player:
        return 'images/player';
      case UploadType.Stadium:
        return 'images/Stadium';
      default:
        throw Exception('Unknown upload type');
    }
  }

  @override
  Future<String> uploadImage(File image, String path) async {
    try {
      Uint8List imageBytes = await image.readAsBytes();
      img.Image? originalImage = img.decodeImage(imageBytes);
      img.Image resizedImage = img.copyResize(originalImage!, width: 800);
      List<int> compressedImage = img.encodeJpg(resizedImage, quality: 85);
      File compressedFile = File('${image.path}_compressed.jpg');
      await compressedFile.writeAsBytes(compressedImage);

      String fileName = basename(compressedFile.path);
      Reference ref = _storage.ref().child('$path/$fileName');
      UploadTask uploadTask = ref.putFile(compressedFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      await compressedFile.delete();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  @override
  Future<String> uploadImageWithType(
      File image, UploadType uploadType, String referenceId) async {
    String path = "${_getPathForUploadType(uploadType)}/$referenceId";
    return await uploadImage(image, path);
  }

  @override
  Future<void> deleteImage(String imageUrl) async {
    try {
      Reference ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  @override
  Future<List<String>> fetchUploadedImages() async {
    try {
      ListResult result = await _storage.ref('images').listAll();
      List<String> urls = [];
      for (Reference ref in result.items) {
        String url = await ref.getDownloadURL();
        urls.add(url);
      }
      return urls;
    } catch (e) {
      throw Exception('Failed to fetch images: $e');
    }
  }
}
