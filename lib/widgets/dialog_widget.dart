import 'package:flutter/material.dart';

class DialogWidget extends StatefulWidget {
  final Function(String)? onAddTask;

  DialogWidget({this.onAddTask});

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      backgroundColor: Colors.grey[700],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Row(
        children: [
          Text(
            'Add Todo',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          Spacer(),
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.cancel,
                color: Colors.grey[200],
              ))
        ],
      ),
      children: [
        Divider(),
        TextFormField(
          controller: titleController,
          autofocus: true,
          style: TextStyle(fontSize: 18.0, height: 1.5, color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Write a Task',
              hintStyle: TextStyle(color: Colors.white30),
              border: InputBorder.none),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          child: TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                widget.onAddTask!(titleController.text.trim());
                Navigator.pop(context);
              } else {
                print('Here you have to use a validator');
              }
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          ),
        )
      ],
    );
  }
}
