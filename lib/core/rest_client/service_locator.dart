import 'package:get_it/get_it.dart';
import 'package:imogoat/core/rest_client/dioCliente.dart';
import 'package:imogoat/models/rest_client.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton<RestClient>(() => DioCliente());
}