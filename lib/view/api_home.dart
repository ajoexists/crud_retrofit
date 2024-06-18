import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retrofit_test/api/rest_client.dart';
import 'package:retrofit_test/model/employee_data.dart';

final locator = GetIt.instance;

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  EmployeeListPageState createState() => EmployeeListPageState();
}

class EmployeeListPageState extends State<EmployeeListPage> {
  late EmployeeApiService _apiService;
  late Future<List<Employee>> _employeeList;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _apiService = locator<EmployeeApiService>();
    _employeeList = fetchEmployees();
  }

  Future<List<Employee>> fetchEmployees() async {
    try {
      final response = await _apiService.getEmployees();
      return response.data;
    } catch (e) {
      print('Error fetching employees: $e');
      return [];
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      await _apiService.deleteEmployee(id);
      setState(() {
        _employeeList = fetchEmployees();
      });
    } catch (e) {
      print('Error deleting employee: $e');
      showErrorDialog('Error deleting employee: $e');
    }
  }

  Future<void> showEditDialog(Employee employee) async {
    final nameController = TextEditingController(text: employee.name);
    final salaryController = TextEditingController(text: employee.salary.toString());
    final ageController = TextEditingController(text: employee.age.toString());

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Employee'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                ),
                TextFormField(
                  controller: salaryController,
                  decoration: const InputDecoration(labelText: 'Salary'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter a salary' : null,
                ),
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter an age' : null,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final updatedEmployee = Employee(
                    name: nameController.text,
                    salary: int.parse(salaryController.text),
                    age: int.parse(ageController.text),
                  );
                  try {
                    await _apiService.updateEmployee(employee.id!, updatedEmployee);
                    setState(() {
                      _employeeList = fetchEmployees();
                    });
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Error updating employee: $e');
                    showErrorDialog('Error updating employee: $e');
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showAddDialog() async {
    final nameController = TextEditingController();
    final salaryController = TextEditingController();
    final ageController = TextEditingController();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Employee'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                ),
                TextFormField(
                  controller: salaryController,
                  decoration: const InputDecoration(labelText: 'Salary'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter a salary' : null,
                ),
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter an age' : null,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final newEmployee = Employee(
                    name: nameController.text,
                    salary: int.parse(salaryController.text),
                    age: int.parse(ageController.text),
                  );
                  try {
                    await _apiService.createEmployee(newEmployee);
                    setState(() {
                      _employeeList = fetchEmployees();
                    });
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Error creating employee: $e');
                    showErrorDialog('Error creating employee: $e');
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: FutureBuilder<List<Employee>>(
        future: _employeeList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()
            );
          }
          else if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Error: ${snapshot.error}'
                )
            );
          }
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
                    'No employees found'
                )
            );
          }
          else {
            final employees = snapshot.data!;
            return ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return ListTile(
                  title: Text(employee.name ?? ''),
                  subtitle: Text(
                      'Age: ${employee.age}, Salary: ${employee.salary}'
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => showEditDialog(employee),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteEmployee(employee.id!),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
