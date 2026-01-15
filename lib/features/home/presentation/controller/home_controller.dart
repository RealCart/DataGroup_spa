import 'dart:async';

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
  StatusEnum getMoreStatus = StatusEnum.initial;

  int get _perPage => 10;

  int _page = 1;
  bool _canGetMore = true;

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
    _page = 1;
    final response = await _repository.searchPhotos(value, page: _page);

    if (response == null) {
      status = StatusEnum.error;
      return;
    }

    if (response.length < _perPage) {
      _canGetMore = false;
    }

    _page++;
    _photos = response;
    status = StatusEnum.success;
    notifyListeners();
  }

  Future<void> getMore(String query) async {
    if (!_canGetMore || getMoreStatus == StatusEnum.loading) {
      return;
    }

    getMoreStatus = StatusEnum.loading;
    final response = await _repository.searchPhotos(query, page: _page);

    if (response == null) {
      status = StatusEnum.error;
      return;
    }

    if (response.length < _perPage) {
      _canGetMore = false;
    }

    status = StatusEnum.success;

    _page++;

    _photos?.addAll(response);
    status = StatusEnum.success;
    notifyListeners();
  }
}
