import 'dart:io';
import 'package:dio/dio.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageRepository {
  final RestClient _rest;

  ImageRepository({required RestClient restClient}) : _rest = restClient;

  Future<bool> createImage(String path, List<File> img, int immobileId) async {
    try {
      // Cria o FormData para envio das imagens via multipart
      FormData formData = FormData.fromMap({
        'img': await Future.wait(
          img.map((image) async => await MultipartFile.fromFile(image.path)).toList(),
        ),
        'immobileId': immobileId, // Mantenha o ID do imóvel aqui
      });
      print(formData);
      
      SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
      String? token = _sharedPreferences.getString('token');

      Response response = await Dio().post(
        'https://imogoat-api.onrender.com/create-image',
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          }
        )
      );
      print(response);
      return true;
    } catch (error) {
      print('Erro ao criar imagem: $error');
      return false;
    }
  }
}
