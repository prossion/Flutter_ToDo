// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';

class TaskFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  const TaskFormWidget(
      {Key? key,
      this.isImportant = false,
      this.number = 0,
      this.title = '',
      this.description = '',
      required this.onChangedImportant,
      required this.onChangedTitle,
      required this.onChangedDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('Is it important?', style: TextStyle(fontSize: 18)),
                Switch(
                  value: isImportant ?? false,
                  onChanged: onChangedImportant,
                ),
              ],
            ),
            TextFormField(
              maxLines: 1,
              initialValue: title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              decoration: InputDecoration(
                hintText: 'Title...',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0.0,
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                ),
              ),
              validator: (title) => title != null && title.isEmpty
                  ? 'The title cannot be empty'
                  : null,
              onChanged: onChangedTitle,
            ),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: 5,
              initialValue: description,
              style: const TextStyle(color: Colors.black, fontSize: 18),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0.0,
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                ),
                fillColor: Colors.black,
                focusColor: Colors.grey,
                hintText: 'Type something...',
                hintStyle: TextStyle(color: Colors.black),
              ),
              validator: (title) => title != null && title.isEmpty
                  ? 'The description cannot be empty'
                  : null,
              onChanged: onChangedDescription,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
