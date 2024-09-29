import 'package:imogoat/models/immobile.dart';
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
}
