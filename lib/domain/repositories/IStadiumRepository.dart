import '../../domain/entities/Stadium.dart';

abstract class IStadiumRepository {
  Future<void> addStadium(Stadium stadium);
  Future<Stadium> getStadiumById(String stadiumId);
  Future<void> updateStadium(Stadium stadium);
  Future<void> deleteStadium(String stadiumId);
}
