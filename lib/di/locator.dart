import 'package:get_it/get_it.dart';
import 'package:retrofit_test/api/dio_client.dart';
import 'package:dio/dio.dart';

import 'package:retrofit_test/api/rest_client.dart';

final getIt = GetIt.instance;

void setupLocator([String? s]) {
  final DioClient dioClient = DioClient(baseUrl: "https://dummy.restapiexample.com/api/v1");

  getIt.registerLazySingleton<Dio>(() => dioClient.dio);
  getIt.registerLazySingleton(() => EmployeeApiService(getIt<Dio>()));
}
