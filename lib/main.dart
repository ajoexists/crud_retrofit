import 'package:flutter/material.dart';
import 'package:retrofit_test/view/api_home.dart';
import 'di/locator.dart';
import 'package:get/get.dart';

void main() {
  setupLocator("https://dummy.restapiexample.com/api/v1");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmployeeListPage(),
    );
  }
}
