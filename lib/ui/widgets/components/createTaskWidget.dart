import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/ui/widgets/components/continueButton.dart';

class CreateTaskWidget extends StatelessWidget {
  final String? priorityValue;
  final TextEditingController dateController;

  const CreateTaskWidget({
    Key? key,
    this.priorityValue,
    required this.dateController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          TextField(
            decoration: const InputDecoration(
                labelText: "Title", border: OutlineInputBorder()),
            onChanged: (value) {},
          ),
          const SizedBox(height: 30),
          TextField(
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  hintText: description, border: OutlineInputBorder()),
              maxLines: null,
              minLines: null,
              onChanged: (value) {}),
          const SizedBox(height: 30),
          Row(
            children: [
              const Text("$priority:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 30),
              DropdownButton<String>(
                value: priorityValue,
                items:
                    priorityData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 30),
          TextField(
              controller: dateController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  String formattedDate = DateFormat("yyyy-mm-dd").format(pickedDate);
                  //FUTURE: update dateController.text : dateController.text = formattedDate.toString()
                } else {
                //FUTURE: show error alert
                }
              }),
              const SizedBox(height: 30),
              ContinueButton(
              text: "Create",
              press: (){},
              backColor: Colors.blue)
        ],
      ),
    );
  }
}
