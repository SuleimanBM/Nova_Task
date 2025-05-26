import "dart:ffi";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:nova_task/features/tasks/domain/entities/task.dart";
import '../bloc/taskBloc.dart';
import '../bloc/taskEvents.dart';
import '../bloc/taskState.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddtaskScreen extends StatefulWidget {
  final Task? task;
  final String pageName;

  AddtaskScreen({super.key, required this.task, required this.pageName});

  @override
  State<AddtaskScreen> createState() => _AddtaskScreenState();
}

class _AddtaskScreenState extends State<AddtaskScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _priorityController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _subtaskController = TextEditingController();

  late bool readOnly;
  TaskBloc get _taskBloc => BlocProvider.of<TaskBloc>(context);

  @override
  void initState() {
    super.initState();
    _initialiseFields();
  }

  void _initialiseFields() {
    if (widget.pageName == "Edit Task") {
      readOnly = true;
      final DateTime date = widget.task!.date;
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _dateController.text = DateFormat('MMM dd, yyyy').format(date).toString();
      _priorityController.text = widget.task!.priority;
      _categoryController.text = widget.task!.category;
      _timeController.text = widget.task!.time;
      _subtaskController.text = widget.task!.subtasks;
    } else {
      readOnly = false;
    }
  }

  void _handleTaskEdit(BuildContext context) {
    // Validate required fields
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _dateController.text.trim().isEmpty ||
        _timeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    try {
      final DateTime parsedDate = DateTime.parse(_dateController.text.trim());

      final Task newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        date: parsedDate,
        time: _timeController.text.trim(),
        priority: _priorityController.text.trim(),
        category: _categoryController.text.trim(),
        subtasks: _subtaskController.text.trim(),
        isCompleted: false,
      );

      // Get the bloc instance safely
      _taskBloc.add(AddTask(newTask));

      // Optionally clear form
      _titleController.clear();
      _descriptionController.clear();
      _dateController.clear();
      _timeController.clear();
      _priorityController.clear();
      _categoryController.clear();
      _subtaskController.clear();

      // Give feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task added successfully')),
      );

      // Optionally navigate back
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid date format: ${_dateController.text}')),
      );
    }
  }

  void _deleteTask(BuildContext context) {
    _taskBloc.add(DeleteTask(widget.task!.id));
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _deleteTask(context);
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(listener: (context, state) {
      if (state is TaskLoaded) {
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          appBar: AppBar(
            title: Text(widget.pageName, style: TextStyle(fontSize: 24.sp)),
            actions: widget.pageName == "Edit Task"
                ? [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            readOnly = !readOnly;
                          });
                        },
                        icon: const Icon(
                          Icons.edit_note_rounded,
                          size: 24,
                        ))
                  ]
                : [],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      readOnly: readOnly,
                      maxLength: 250,
                      cursorWidth: 1,
                      maxLines: null,
                      minLines: 2,
                      style: TextStyle(fontSize: 16.sp),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Title',
                          labelStyle: TextStyle(fontSize: 16.sp),
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          filled: true),
                    ),
                    16.verticalSpace,
                    TextField(
                      controller: _descriptionController,
                      readOnly: readOnly,
                      maxLength: 500,
                      cursorWidth: 1,
                      maxLines: null,
                      minLines: 6,
                      style: TextStyle(fontSize: 16.sp),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Description',
                          labelStyle: TextStyle(fontSize: 16.sp),
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          filled: true),
                    ),
                    16.verticalSpace,
                    TextField(
                      controller: _priorityController,
                      readOnly: readOnly,
                      style: TextStyle(fontSize: 16.sp),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Priority',
                        labelStyle: TextStyle(fontSize: 16.sp),
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        suffixIcon: DropdownButton(
                          items: [
                            DropdownMenuItem(
                              value: 'High',
                              child: Text('High',
                                  style: TextStyle(fontSize: 12.sp)),
                            ),
                            DropdownMenuItem(
                              value: 'Medium',
                              child: Text('Medium',
                                  style: TextStyle(fontSize: 12.sp)),
                            ),
                            DropdownMenuItem(
                              value: 'Low',
                              child: Text('Low',
                                  style: TextStyle(fontSize: 12.sp)),
                            ),
                          ],
                          onChanged: (String? newPriority) {
                            setState(() {
                              _priorityController.text = newPriority!;
                            });
                          },
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    TextField(
                      controller: _categoryController,
                      readOnly: true,
                      style: TextStyle(fontSize: 16.sp),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Category',
                        labelStyle: TextStyle(fontSize: 16.sp),
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        suffixIcon: DropdownButton(
                          items: [
                            DropdownMenuItem(
                              value: 'Work',
                              child: Text('Work',
                                  style: TextStyle(fontSize: 12.sp)),
                            ),
                            DropdownMenuItem(
                              value: 'School',
                              child: Text('School',
                                  style: TextStyle(fontSize: 12.sp)),
                            ),
                            DropdownMenuItem(
                              value: 'Home',
                              child: Text('Home',
                                  style: TextStyle(fontSize: 12.sp)),
                            ),
                            DropdownMenuItem(
                              value: 'Casual',
                              child: Text('Casual',
                                  style: TextStyle(fontSize: 12.sp)),
                            ),
                          ],
                          onChanged: (String? newCategory) {
                            setState(() {
                              _categoryController.text = newCategory!;
                            });
                          },
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    TextField(
                      controller: _dateController,
                      style: TextStyle(fontSize: 16.sp),
                      readOnly: true,
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          setState(() {
                            _dateController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          });
                        }
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Date',
                          labelStyle: TextStyle(fontSize: 16.sp),
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.calendar_month,
                              size: 16.sp,
                            ),
                          )),
                    ),
                    16.verticalSpace,
                    TextField(
                      controller: _timeController,
                      style: TextStyle(fontSize: 16.sp),
                      readOnly: true,
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            _timeController.text =
                                pickedTime.format(context).toString();
                          });
                        }
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Time',
                        labelStyle: TextStyle(fontSize: 16.sp),
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                      ),
                    ),
                    16.verticalSpace,
                    TextField(
                        controller: _subtaskController,
                        readOnly: readOnly,
                        maxLength: 250,
                        cursorWidth: 1,
                        maxLines: null,
                        minLines: 2,
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Subtasks',
                          labelStyle: TextStyle(fontSize: 16.sp),
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          filled: true,
                        )),
                    16.verticalSpace,
                    // ignore: prefer_const_constructors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => _confirmDelete(context),
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                  Color.fromARGB(255, 48, 48, 48)),
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 32.w),
                              )),
                          child: Text(
                            "Delete Task",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _handleTaskEdit(context),
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                  Color.fromARGB(255, 48, 48, 48)),
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 32.w),
                              )),
                          child: Text(
                            "Save Task",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ));
    });
  }
}
