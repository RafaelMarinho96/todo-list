import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/models/todo.dart';

// Intl Import
import 'package:intl/intl.dart';

class DatabaseService {
  CollectionReference allCollection =
      FirebaseFirestore.instance.collection('all');

  getDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('dd/MM/yyyy - kk:mm').format(now);
  }

  Future createNewOne(String title) async {
    await allCollection.add({
      'title': title,
      'isChecked': false,
      'createdAt': getDateTime(),
      'completedAt': ''
    });
  }

  Future completeTask(uid) async {
    await allCollection
        .doc(uid)
        .update({'isChecked': true, 'completedAt': getDateTime()});
  }

  Future notCompletedTask(uid) async {
    await allCollection
        .doc(uid)
        .update({'isChecked': false, 'completedAt': ''});
  }

  Future deleteTask(uid) async {
    await allCollection.doc(uid).delete();
  }

  List<Todo>? todoFromFirestore(QuerySnapshot? snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Todo(
          uid: e.id,
          title: (e.data() as dynamic)['title'],
          isChecked: (e.data() as dynamic)['isChecked'],
          createdAt: (e.data() as dynamic)['createdAt'],
          completedAt: (e.data() as dynamic)['completedAt'],
        );
      }).toList();
    } else {
      return null;
    }
  }

  Stream<List<Todo>?> listAll() {
    return allCollection
        .snapshots()
        .map((snapshot) => todoFromFirestore(snapshot));
  }
}
