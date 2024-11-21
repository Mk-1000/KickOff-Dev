import '../../business/services/StadiumService.dart';
import '../../domain/entities/Stadium.dart';
import '../../domain/services/IStadiumService.dart';

class StadiumManager {
  final IStadiumService _stadiumService;

  StadiumManager({IStadiumService? stadiumService})
      : _stadiumService = stadiumService ?? StadiumService();

  Future<void> createStadium(Stadium stadium) async {
    try {
      await _stadiumService.createStadium(stadium);
    } catch (e) {
      throw Exception('Failed to create stadium: $e');
    }
  }

  Future<Stadium> getStadiumDetails(String stadiumId) async {
    try {
      return await _stadiumService.getStadiumDetails(stadiumId);
    } catch (e) {
      throw Exception('Failed to get stadium details: $e');
    }
  }

  Future<void> updateStadium(Stadium stadium) async {
    try {
      await _stadiumService.updateStadium(stadium);
    } catch (e) {
      throw Exception('Failed to update stadium: $e');
    }
  }

  Future<void> deleteStadium(String stadiumId) async {
    try {
      await _stadiumService.deleteStadium(stadiumId);
    } catch (e) {
      throw Exception('Failed to delete stadium: $e');
    }
  }

  Future<List<Stadium>> getAllStadiums() async {
    try {
      return await _stadiumService.getAllStadiums();
    } catch (e) {
      throw Exception('Failed to get all stadiums: $e');
    }
  }
}
