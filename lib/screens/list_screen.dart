import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/screens/card_screen.dart';
import 'package:todo_list/services/database_service.dart';

// Widgets Import
import 'package:todo_list/widgets/loading.dart';
import 'package:todo_list/widgets/list_widget.dart';
import 'package:todo_list/widgets/dialog_widget.dart';
import 'package:todo_list/widgets/heading_widget.dart';

import 'package:speed_dial_fab/speed_dial_fab.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool isChecked = false;
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: StreamBuilder<List<Todo>?>(
              stream: DatabaseService().listAll(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Loading();
                }
                List<Todo>? all = snapshot.data;
                return Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingWidget(),
                      Divider(),
                      SizedBox(
                        height: 20.0,
                      ),
                      ListWidget(
                        tasks: (all as dynamic),
                        onDeleteTask: (uid) async {
                          await DatabaseService().deleteTask(uid);
                        },
                        onUpdateTask: (isChecked, uid) async {
                          if (isChecked) {
                            await DatabaseService().notCompletedTask(uid);
                          } else {
                            await DatabaseService().completeTask(uid);
                          }
                        },
                      ),
                    ],
                  ),
                );
              })),
      floatingActionButton: SpeedDialFabWidget(
        secondaryIconsOnPress: [
          () => {
                showDialog(
                    context: context,
                    builder: (builder) {
                      return DialogWidget(
                        onAddTask: (value) async {
                          await DatabaseService().createNewOne(value);
                        },
                      );
                    })
              },
          () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CardScreen()))
              },
        ],
        secondaryIconsList: [
          Icons.add,
          Icons.amp_stories,
        ],
        secondaryIconsText: [
          "Create",
          "Flash Card",
        ],
        secondaryBackgroundColor: Colors.pink,
        secondaryForegroundColor: Colors.white,
        primaryBackgroundColor: Colors.pink,
        primaryForegroundColor: Colors.white,
      ),
      /* floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (builder) {
                return DialogWidget(
                  onAddTask: (value) async {
                    await DatabaseService().createNewOne(value);
                  },
                );
              });
        },
      ), */
    );
  }
}
