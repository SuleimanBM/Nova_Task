import "package:flutter/material.dart";
import "package:intl/intl.dart";

class AddtaskScreen extends StatefulWidget {
  AddtaskScreen({super.key});

  @override
  State<AddtaskScreen> createState() => _AddtaskScreenState();
}

class _AddtaskScreenState extends State<AddtaskScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          title: const Text("Add Task"),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit_note_rounded, size: 32,))],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  const TextField(
                    maxLength: 250,
                    cursorWidth: 1,
                    maxLines: null,
                    minLines: 2,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    maxLength: 500,
                    cursorWidth: 1,
                    maxLines: null,
                    minLines: 6,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _priorityController,
                    readOnly: true,
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Time',
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                      maxLength: 250,
                      cursorWidth: 1,
                      maxLines: null,
                      minLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Subtasks',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                      )),
                  const SizedBox(height: 16),
                  // ignore: prefer_const_constructors
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      TextButton(
                        onPressed: null,
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                                Color.fromARGB(255, 48, 48, 48)),
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                            )),
                        child: Text(
                          "Delete Task",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      TextButton(
                        onPressed: null,
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                                Color.fromARGB(255, 48, 48, 48)),
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                            )),
                        child: Text(
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
  }
}
