import '../entities/Stadium.dart';

abstract class IStadiumRepository {
  Future<List<Stadium>> getAllStadiums();
  Future<Stadium> getStadiumById(String id);
  Future<void> addStadium(Stadium stadium);
  Future<void> updateStadium(Stadium stadium);
  Future<void> deleteStadium(String id);
}
