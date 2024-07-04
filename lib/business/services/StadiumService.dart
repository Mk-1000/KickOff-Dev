import '../../domain/entities/Stadium.dart';
import '../../domain/repositories/IStadiumRepository.dart';
import '../../domain/services/IStadiumService.dart';

class StadiumService implements IStadiumService {
  final IStadiumRepository _stadiumRepository;

  StadiumService(this._stadiumRepository);

  @override
  Future<void> createStadium(Stadium stadium) async {
    try {
      await _stadiumRepository.addStadium(stadium);
    } catch (e) {
      throw Exception('Failed to create stadium: $e');
    }
  }

  @override
  Future<List<Stadium>> getAllStadiums() async {
    try {
      return await _stadiumRepository.getAllStadiums();
    } catch (e) {
      throw Exception('Failed to get all stadiums: $e');
    }
  }

  @override
  Future<Stadium> getStadiumDetails(String stadiumId) async {
    try {
      return await _stadiumRepository.getStadiumById(stadiumId);
    } catch (e) {
      throw Exception('Failed to get stadium details: $e');
    }
  }

  @override
  Future<void> updateStadium(Stadium stadium) async {
    try {
      await _stadiumRepository.updateStadium(stadium);
    } catch (e) {
      throw Exception('Failed to update stadium: $e');
    }
  }
}
