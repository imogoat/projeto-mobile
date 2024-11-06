import 'package:imogoat/models/immobile.dart';
import 'package:imogoat/models/immobile_post.dart';
import 'package:imogoat/models/rest_client.dart';

class ImmobileRepository {
  final RestClient _rest;
  ImmobileRepository({required RestClient restClient}) : _rest = restClient;

 Future<List<Immobile>> buscarImovel() async {
    final response = await _rest.get('/immobile');
    return (response as List)
        .map<Immobile>((item) => Immobile.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  Future<bool> createImmobile(String path, ImmobilePost data) async {
    try {
      await _rest.post(path, data.toMap());
      return true;
    } catch (error) {
      print('Erro ao criar imóvel: $error');
      return false;
    }
  }

  Future<void> deleteImmobile(String immobileId) async {
    try {
      print('Entrou aqui 1');
      print('Id do imóvel 2: $immobileId');
      await _rest.delete('https://imogoat-api.onrender.com/delete-immobile', immobileId);
    } catch (error) {
      print('entrou aqui 2');
      print('Erro ao deletar imóvel: $error');
      rethrow;
    }
  }

  Future<int?> getLastCreatedImmobileId() async {
    try {
      final response = await _rest.get('/immobile');

      if (response.isNotEmpty) {
        response.sort((a, b) => (b['id'] as int).compareTo(a['id'] as int));
        return response[0]['id'];
      }
    } catch (error) {
      print('Erro ao buscar o último imóvel criado: $error');
    }
    return null;
  }

}
