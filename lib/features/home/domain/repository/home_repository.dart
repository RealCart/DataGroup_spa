import 'package:spa_project/features/home/domain/entity/photo_entity.dart';

abstract interface class HomeRepository {
  Future<List<PhotoEntity>?> randomPhotos();
  Future<List<PhotoEntity>?> searchPhotos(String value);
}
