import 'package:json_annotation/json_annotation.dart';

part 'employee_data.g.dart';

@JsonSerializable()
class Employee {
  final int? id;
  @JsonKey(name: 'employee_name')
  final String? name;
  @JsonKey(name: 'employee_salary')
  final int? salary;
  @JsonKey(name: 'employee_age')
  final int? age;
  @JsonKey(name: 'profile_image')
  final String? profileImage;

  Employee({
    this.id,
    this.name,
    this.salary,
    this.age,
    this.profileImage});

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}