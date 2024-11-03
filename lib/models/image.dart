import 'dart:io';
import 'package:dio/dio.dart';

class ImagePost {
  final List<File> img;
  final int immobileId;

  ImagePost({
    required this.img,
    required this.immobileId,
  });

  factory ImagePost.fromMap(Map<String, dynamic> map) {
    List<File> images = (map['img'] as List<dynamic>).map((imagePath) => File(imagePath)).toList();

    return ImagePost(
      img: images,
      immobileId: map['immobileId'],
    );
  }

  Future<Map<String, dynamic>> toMap() async {
    List<MultipartFile> multipartImages = [];
    
    for (var image in img) {
      String fileName = image.path.split('/').last;
      multipartImages.add(await MultipartFile.fromFile(image.path, filename: fileName));
    }

    return {
      'img': multipartImages,
      'immobileId': immobileId,
    };
  }
}
