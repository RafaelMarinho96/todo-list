import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

// Models Import
import 'package:todo_list/models/todo.dart';

// Database Service Import
import 'package:todo_list/services/database_service.dart';

// Widgets Import
import 'package:todo_list/widgets/cards_widget.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Flash Cards'),
      ),
      body: Container(
          child: StreamBuilder<List<Todo>?>(
              stream: DatabaseService().listAll(),
              builder: (context, snapshot) {
                List<Todo>? tasks = snapshot.data;
                if (snapshot.hasData) {
                  return CardsWidget(
                    tasks: tasks,
                    onSwipeCard: (uid, direction) async {
                      final complete = direction == SwipeDirection.right;
                      final notComplete = direction == SwipeDirection.left;
                      final delete = direction == SwipeDirection.down;

                      if (complete) {
                        await DatabaseService().completeTask(uid);
                      } else if (notComplete) {
                        await DatabaseService().notCompletedTask(uid);
                      } else if (delete) {
                        await DatabaseService().deleteTask(uid);
                      } else {}
                    },
                  );
                }
                return Container();
              })),
    );
  }
}
