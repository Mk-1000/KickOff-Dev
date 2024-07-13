import '../../domain/entities/Stadium.dart';

abstract class IStadiumService {
  Future<void> createStadium(Stadium stadium);
  Future<Stadium> getStadiumDetails(String stadiumId);
  Future<void> updateStadium(Stadium stadium);
  Future<void> deleteStadium(String stadiumId);
  Future<List<Stadium>> getAllStadiums();
}
