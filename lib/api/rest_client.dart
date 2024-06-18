import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:retrofit_test/model/employee_data.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://dummy.restapiexample.com/api/v1")
abstract class EmployeeApiService {
  factory EmployeeApiService(Dio dio, {String baseUrl}) = _EmployeeApiService;

  @GET("/employees")
  Future<EmployeeListResponse> getEmployees();

  @GET("/employee/{id}")
  Future<Employee> getEmployee(@Path("id") int id);

  @POST("/create")
  Future<Employee> createEmployee(@Body() Employee employee);

  @PUT("/update/{id}")
  Future<Employee> updateEmployee(@Path("id") int id, @Body() Employee employee);

  @DELETE("/delete/{id}")
  Future<void> deleteEmployee(@Path("id") int id);
}

@JsonSerializable()
class EmployeeListResponse {
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'data')
  final List<Employee> data;

  EmployeeListResponse({required this.status, required this.data});

  factory EmployeeListResponse.fromJson(Map<String, dynamic> json) => _$EmployeeListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeListResponseToJson(this);
}
