import 'package:flutter/material.dart';

// Import Models
import 'package:todo_list/models/todo.dart';

class ListWidget extends StatelessWidget {
  final List<Todo>? tasks;
  final Function(bool, String)? onUpdateTask;
  final Function(String)? onDeleteTask;

  ListWidget({
    this.tasks,
    this.onUpdateTask,
    this.onDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    if ((tasks as dynamic)?.length > 0) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: (tasks as dynamic).length,
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[800],
          );
        },
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key((tasks as dynamic)[index].uid),
            background: Container(
              padding: EdgeInsets.only(left: 20.0),
              alignment: Alignment.centerLeft,
              child: Icon(Icons.delete),
              color: Colors.red,
            ),
            onDismissed: (direction) {
              onDeleteTask!((tasks as dynamic)[index].uid);
            },
            child: ListTile(
              onTap: () {
                onUpdateTask!((tasks as dynamic)[index].isChecked,
                    (tasks as dynamic)[index].uid);
              },
              title: Text(
                (tasks as dynamic)[index].title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[200]),
              ),
              subtitle: _getDateTime((tasks as dynamic)[index].createdAt,
                  (tasks as dynamic)[index].completedAt),
              leading: Container(
                padding: EdgeInsets.all(2),
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                child: (tasks as dynamic)[index].isChecked
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : Container(),
              ),
            ),
          );
        },
      );
    }
    return Container(
      child: Text('You have to add a progress bar here!'),
    );
  }

  _getDateTime(createdAt, completedAt) {
    if (completedAt != '') {
      return Text(
        'Finalizado em: $completedAt',
        style: TextStyle(fontSize: 15.0, color: Colors.white),
      );
    } else if (createdAt != '') {
      return Text(
        'Criado em: $createdAt',
        style: TextStyle(fontSize: 15.0, color: Colors.white),
      );
    } else {
      Container();
    }
  }
}
