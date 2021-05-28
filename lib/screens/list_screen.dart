import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/database_service.dart';
import 'package:todo_list/widgets/loading.dart';

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
                      Text(
                        'Personal List',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Divider(),
                      SizedBox(
                        height: 20.0,
                      ),
                      ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.grey[800],
                              ),
                          shrinkWrap: true,
                          itemCount: (all as dynamic).length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key((all as dynamic)[index].uid),
                              background: Container(
                                padding: EdgeInsets.only(left: 20.0),
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                              onDismissed: (direction) async {
                                await DatabaseService()
                                    .deleteTask((all as dynamic)[index].uid);
                              },
                              child: ListTile(
                                onTap: () async {
                                  if ((all as dynamic)[index].isChecked) {
                                    await DatabaseService().notCompletedTask(
                                        (all as dynamic)[index].uid);
                                  } else {
                                    await DatabaseService().completeTask(
                                        (all as dynamic)[index].uid);
                                  }
                                },
                                title: Text(
                                  (all as dynamic)[index].title,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[200]),
                                ),
                                leading: Container(
                                  padding: EdgeInsets.all(2),
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle),
                                  child: (all as dynamic)[index].isChecked
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : Container(),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                );
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (builder) {
                return SimpleDialog(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  backgroundColor: Colors.grey[700],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
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
                      style: TextStyle(
                          fontSize: 18.0, height: 1.5, color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Write a task',
                          hintStyle: TextStyle(color: Colors.white30),
                          border: InputBorder.none),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      child: TextButton(
                        onPressed: () async {
                          if (titleController.text.isNotEmpty) {
                            await DatabaseService()
                                .createNewOne(titleController.text.trim());
                            Navigator.pop(context);
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
              });
        },
      ),
    );
  }
}
