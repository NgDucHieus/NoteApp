import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {

  List toDolIST = [];
  final _myBox = Hive.box("mybox");

  //run this method if it the first time open the app
  void createIntialData() {
    toDolIST = [
      ["Make tutorial", false],
      ["Do excersised", false],
      ["Do homework", false]
    ];
  }

  //load the data
  void loadData() {
    toDolIST = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put("TODOLIST", toDolIST);
  }

}
