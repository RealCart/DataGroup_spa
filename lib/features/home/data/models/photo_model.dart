import 'package:spa_project/features/home/domain/entity/photo_entity.dart';

class PhotoModel {
  const PhotoModel({
    required this.path,
  });

  final String path;

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      path: json['urls']['full'] as String,
    );
  }

  PhotoEntity toEntity() {
    return PhotoEntity(path: path);
  }
}
