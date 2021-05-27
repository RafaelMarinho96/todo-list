import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/models/todo.dart';

class DatabaseService {
  CollectionReference allCollection =
      FirebaseFirestore.instance.collection('all');

  Future createNewOne(String title) async {
    await allCollection.add({
      "title": title,
      "isChecked": false,
    });
  }

  Future completeTask(uid) async {
    await allCollection.doc(uid).update({'isChecked': true});
  }

  List<Todo>? todoFromFirestore(QuerySnapshot? snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Todo(
          uid: e.id,
          title: (e.data() as dynamic)["title"],
          isChecked: (e.data() as dynamic)["isChecked"],
        );
      }).toList();
    } else {
      return null;
    }
  }

  Stream<List<Todo>?> listTodos() {
    return allCollection
        .snapshots()
        .map((snapshot) => todoFromFirestore(snapshot));
  }
}
