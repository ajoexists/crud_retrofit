import 'package:json_annotation/json_annotation.dart';
import 'employee_data.dart';

part 'employee_response.g.dart';

@JsonSerializable()
class EmployeeResponse {
  final String status;
  final List<Employee> data;

  EmployeeResponse({
    required this.status,
    required this.data});

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) => _$EmployeeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeResponseToJson(this);
}
