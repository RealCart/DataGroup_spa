import 'dart:convert';
import 'dart:developer';

import 'package:spa_project/core/constants/app_api.dart';
import 'package:http/http.dart';
import 'package:spa_project/features/home/data/models/photo_model.dart';

abstract interface class HomeRemote {
  Future<List<PhotoModel>> getRandomPhoto();
  Future<List<PhotoModel>> searchPhoto(String value, {required int page});
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

    final data = (jsonDecode(response.body) as List)
        .map((e) => PhotoModel.fromJson(e))
        .toList();

    log('''
      $data
      ''', name: "Response body");

    return data;
  }

  @override
  Future<List<PhotoModel>> searchPhoto(
    String value, {
    required int page,
  }) async {
    log("SEARCHING...", name: "searchPhoto");

    // final response = await _httpClient.get(
    //   Uri.parse("${AppApi.searchPhoto}?query=$value&page=$page"),
    //   headers: {
    //     'Content-type': 'application/json',
    //     'Accept': 'application/json',
    //     'Accept-Version': 'v1',
    //     'Authorization':
    //         'Client-ID LF-BxUP8GQFqqe51Qa8z8hEKePn3m60JAxeuDm8IBuI',
    //   },
    // );

    // final data = ((jsonDecode(response.body) as Map)['results'] as List)
    //     .map((e) => PhotoModel.fromJson(e))
    //     .toList();

    await Future.delayed(const Duration(seconds: 3));

    final data = List.generate(
      10,
      (_) => PhotoModel(
        path:
            "https://zvetnoe.ru/upload/images/blog/135_Peizazhnaya_zhivopis_istorya_osnovnye_vidy_i_stili/0.jpg",
      ),
    );

    return data;
  }
}
