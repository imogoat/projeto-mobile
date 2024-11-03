import 'dart:io';
import 'package:flutter/material.dart';
import 'package:imogoat/repositories/image_repository.dart';

class ControllerImage extends ChangeNotifier {
  final ImageRepository _imageRepository;

  bool loading = false;
  bool result = true;

  ControllerImage({required ImageRepository imageRepository}) : _imageRepository = imageRepository;

  Future<void> createImage(String path, List<File> img, int immobileId) async {
    try {
      loading = true;
      result = true;
      notifyListeners();

      // ImagePost imagePost = ImagePost(
      //   img: img, 
      //   immobileId: immobileId
      // );

      await _imageRepository.createImage(path, img, immobileId);
    } catch (e) {
      result = false;
      debugPrint('Erro ao enviar as imagens: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
