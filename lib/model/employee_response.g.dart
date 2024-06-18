// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeResponse _$EmployeeResponseFromJson(Map<String, dynamic> json) =>
    EmployeeResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeeResponseToJson(EmployeeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
