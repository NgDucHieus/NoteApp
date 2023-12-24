import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/data/database.dart';
import 'package:note_app/util/dialog_box.dart';
import 'package:note_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  TodoDataBase db = TodoDataBase();
  @override
  void initState() {
    // if this is the first time ever openin the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createIntialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();
  //list of todo tasks

  //Checkbox
  void checkBoxChagef(bool? value, int index) {
    setState(() {
      db.toDolIST[index][1] = !db.toDolIST[index][1];
      _controller.clear();
    });
    db.updateData();
  }

  //save new Task
  void saveNewTask() {
    setState(() {
      db.toDolIST.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (builder) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDolIST.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text("TO DO"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDolIST.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDolIST[index][0],
            onChanged: (value) => {checkBoxChagef(value, index)},
            taskCompleted: db.toDolIST[index][1],
            deleteFuction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
