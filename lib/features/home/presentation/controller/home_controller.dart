import 'package:flutter/material.dart';
import 'package:spa_project/core/utils/status_enum.dart';
import 'package:spa_project/features/home/data/repository_impl/home_repository_impl.dart';
import 'package:spa_project/features/home/domain/entity/photo_entity.dart';
import 'package:spa_project/features/home/domain/repository/home_repository.dart';

class HomeController extends ChangeNotifier {
  HomeController();

  final HomeRepository _repository = HomeRepositoryImpl();

  List<PhotoEntity>? get photo => _photos;

  List<PhotoEntity>? _photos = [];
  StatusEnum status = StatusEnum.initial;

  Future<void> randomPhotos() async {
    status = StatusEnum.loading;
    notifyListeners();
    final response = await _repository.randomPhotos();

    if (response == null) {
      status = StatusEnum.error;
      return;
    }

    _photos = response;
    status = StatusEnum.success;
    notifyListeners();
  }

  Future<void> search(String value) async {
    final response = await _repository.searchPhotos(value);

    _photos = response;
    notifyListeners();
  }
}
