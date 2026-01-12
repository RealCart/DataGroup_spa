import 'dart:convert';

import 'package:spa_project/core/constants/app_api.dart';
import 'package:http/http.dart';
import 'package:spa_project/features/home/data/models/photo_model.dart';

abstract interface class HomeRemote {
  Future<List<PhotoModel>> getRandomPhoto();
  Future<List<PhotoModel>> searchPhoto(String value);
}

class HomeRemoteImpl implements HomeRemote {
  HomeRemoteImpl();

  final Client _httpClient = Client();

  @override
  Future<List<PhotoModel>> getRandomPhoto() async {
    final response = await _httpClient.get(
      Uri.parse("${AppApi.randomPhoto}?count=8"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Accept-Version': 'v1',
        'Authorization':
            'Client-ID LF-BxUP8GQFqqe51Qa8z8hEKePn3m60JAxeuDm8IBuI',
      },
    );

    return (jsonDecode(response.body) as List)
        .map((e) => PhotoModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<PhotoModel>> searchPhoto(String value) {
    // TODO: implement searchPhoto
    throw UnimplementedError();
  }
}
