import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Models Import
import 'package:todo_list/models/todo.dart';

// Swipable Stack Import
import 'package:swipable_stack/swipable_stack.dart';

//Widgets Import
import 'package:todo_list/widgets/card_label_widget.dart';

class CardsWidget extends StatefulWidget {
  final List<Todo>? tasks;
  final Function(String, SwipeDirection)? onSwipeCard;

  CardsWidget({this.tasks, this.onSwipeCard});

  @override
  _CardsWidgetState createState() => _CardsWidgetState();
}

class _CardsWidgetState extends State<CardsWidget> {
  SwipableStackController? _controller;
  bool _isTheLastOne = false;

  void _listenController() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isTheLastOne) {
      return SwipableStack(
          controller: _controller,
          itemCount: (widget.tasks as dynamic).length,
          onSwipeCompleted: (index, direction) {
            if ((widget.tasks as dynamic).length == index + 1) {
              setState(() {
                _isTheLastOne = true;
              });
            }
            widget.onSwipeCard!(
                (widget.tasks as dynamic)[index].uid, direction);
          },
          overlayBuilder:
              (context, constraints, index, direction, swipeProgress) {
            final opacity = min(swipeProgress, 1.0);
            final isRight = direction == SwipeDirection.right;
            final isLeft = direction == SwipeDirection.left;
            final isDown = direction == SwipeDirection.down;

            return Padding(
              padding: EdgeInsets.only(top: 70.0, left: 40.0),
              child: Stack(
                children: [
                  Opacity(
                    child: CardLabelWidget(
                      text: 'Concluido',
                      color: Colors.green,
                    ),
                    opacity: isRight ? opacity : 0,
                  ),
                  Opacity(
                    opacity: isLeft ? opacity : 0,
                    child: CardLabelWidget(
                      text: 'Não Concluido',
                      color: Colors.yellow,
                    ),
                  ),
                  Opacity(
                    opacity: isDown ? opacity : 0,
                    child: CardLabelWidget(
                      text: 'Remover',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          },
          onWillMoveNext: (index, direction) {
            final allowedActions = [
              SwipeDirection.right,
              SwipeDirection.left,
              SwipeDirection.down
            ];
            return allowedActions.contains(direction);
          },
          builder: (context, index, constraints) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Card(
                color: Color(0xff2B3C4E),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (widget.tasks as dynamic)[index].title,
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    _getTaskState((widget.tasks as dynamic)[index].createdAt,
                        (widget.tasks as dynamic)[index].completedAt)
                  ],
                ),
              ),
            );
          });
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Card(
        color: Color(0xff2B3C4E),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🥳', style: TextStyle(fontSize: 40.0)),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Yeehhhh!',
              style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              'You looked at all your tasks',
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: OutlinedButton(
                child: Text('Go back to Home'),
                style: OutlinedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  primary: Colors.pink[400],
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  side: BorderSide(color: Colors.pink, width: 2),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getTaskState(createdAt, completedAt) {
    if (completedAt != '') {
      return Text(
        'Concluido',
        style: TextStyle(
            color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.normal),
      );
    } else if (createdAt != '') {
      return Text('Em andamento',
          style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.normal));
    } else {
      return Container();
    }
  }
}
