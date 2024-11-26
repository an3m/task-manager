import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/models/task.dart';
import 'package:tasks_manager/controllers/task_controller.dart';

// ignore: must_be_immutable
class InputForm extends StatelessWidget {
  InputForm({Key? key}) : super(key: key);

  final TaskController taskController = Get.find<TaskController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Set today's date by default if no date is provided
  Task _newTask = Task(
    id: null,
    title: '',
    description: '',
    date: DateTime.now(), // Default to today's date
    isCompleted: false,
    isFavorite: false,
  );

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      taskController.addTask(_newTask);
      Get.back();
    }
  }
void showDialog (BuildContext context) {  Get.defaultDialog(
        title: 'Add Task',
        titleStyle: Theme.of(context).textTheme.titleMedium,
        onCancel: () => Get.back(),
        onConfirm: _saveForm,
        confirmTextColor: Theme.of(context).colorScheme.onPrimary,
        buttonColor: Theme.of(context).colorScheme.primary,
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Title is required'
                    : null,
                onSaved: (newValue) {
                  _newTask.title = newValue;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Description is required'
                    : null,
                onSaved: (newValue) {
                  _newTask.description = newValue;
                },
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  // If the user doesn't pick a date, use the default one
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _newTask.date!, // Start with today's date
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _newTask.date = pickedDate;
                  }
                },
                child: Text(
                  'Select Date: ${_newTask.date!.toLocal().toString().split(' ')[0]}', // Display selected date
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );}
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      
      onPressed:  ()=>showDialog(context) ,
      child: Icon(
        Icons.add,
        size: MediaQuery.of(context).size.width * 0.06,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
