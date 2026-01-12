import 'dart:developer';

import 'package:spa_project/features/home/data/sources/remote/home_remote.dart';
import 'package:spa_project/features/home/domain/entity/photo_entity.dart';
import 'package:spa_project/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl();

  final _remote = HomeRemoteImpl();

  @override
  Future<List<PhotoEntity>?> randomPhotos() async {
    try {
      final response = await _remote.getRandomPhoto();

      return response.map((e) => e.toEntity()).toList();
    } catch (e, stackTrace) {
      log(
        '''
        Error: $e,
        StackTrace: $stackTrace,
        ''',
        name: "Error while fetching randomPhotos",
      );
      return null;
    }
  }

  @override
  Future<List<PhotoEntity>?> searchPhotos(String value) {
    // TODO: implement searchPhotos
    throw UnimplementedError();
  }
}
