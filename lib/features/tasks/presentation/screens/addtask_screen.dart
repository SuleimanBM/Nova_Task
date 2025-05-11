import "dart:ffi";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:nova_task/features/tasks/domain/entities/task.dart";
import '../bloc/taskBloc.dart';
import '../bloc/taskEvents.dart';
import '../bloc/taskState.dart';

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
      BlocProvider.of<TaskBloc>(context).add(AddTask(newTask));

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      listener:
      (context, state) {
        if (state is TaskLoaded) {
          Navigator.pop(context);
        }
      };
      return Scaffold(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          appBar: AppBar(
            title: Text(widget.pageName),
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
                          size: 32,
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
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          filled: true),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _descriptionController,
                      readOnly: readOnly,
                      maxLength: 500,
                      cursorWidth: 1,
                      maxLines: null,
                      minLines: 6,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          filled: true),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _priorityController,
                      readOnly: readOnly,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Priority',
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        suffixIcon: DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              value: 'High',
                              child: Text('High'),
                            ),
                            DropdownMenuItem(
                              value: 'Medium',
                              child: Text('Medium'),
                            ),
                            DropdownMenuItem(
                              value: 'Low',
                              child: Text('Low'),
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
                    const SizedBox(height: 16),
                    TextField(
                      controller: _categoryController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Category',
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        suffixIcon: DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              value: 'Work',
                              child: Text('Work'),
                            ),
                            DropdownMenuItem(
                              value: 'School',
                              child: Text('School'),
                            ),
                            DropdownMenuItem(
                              value: 'Home',
                              child: Text('Home'),
                            ),
                            DropdownMenuItem(
                              value: 'Casual',
                              child: Text('Casual'),
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
                    const SizedBox(height: 16),
                    TextField(
                      controller: _dateController,
                      readOnly: readOnly,
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
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Date',
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(Icons.calendar_month),
                          )),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _timeController,
                      readOnly: readOnly,
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Time',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                        controller: _subtaskController,
                        readOnly: readOnly,
                        maxLength: 250,
                        cursorWidth: 1,
                        maxLines: null,
                        minLines: 2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Subtasks',
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          filled: true,
                        )),
                    const SizedBox(height: 16),
                    // ignore: prefer_const_constructors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextButton(
                          onPressed: null,
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                  Color.fromARGB(255, 48, 48, 48)),
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 32),
                              )),
                          child: Text(
                            "Delete Task",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _handleTaskEdit(context),
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                  Color.fromARGB(255, 48, 48, 48)),
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 32),
                              )),
                          child: const Text(
                            "Save Task",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
