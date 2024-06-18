// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: (json['id'] as num?)?.toInt(),
      name: json['employee_name'] as String?,
      salary: (json['employee_salary'] as num?)?.toInt(),
      age: (json['employee_age'] as num?)?.toInt(),
      profileImage: json['profile_image'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'employee_name': instance.name,
      'employee_salary': instance.salary,
      'employee_age': instance.age,
      'profile_image': instance.profileImage,
    };
