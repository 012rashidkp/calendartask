

import 'package:calendartask/model/task.dart';
import 'package:hive/hive.dart';

class CalendarRepository{
  Future<void>addTask({Task? value}) async{
    final persondb=await Hive.box<Task>('task');
    persondb.add(value!);
  }

  Future<List<Task>> getAlltasks() async {

    final taskdb   = Hive.box<Task>("task");
    List<Task> _person = [];
    print('tasks... ${taskdb.values}');

    final tasklist = taskdb.values.toList().cast<Task>();

    final filteredList = tasklist.where((person) => person != null).toList();
    _person.clear();
    _person.addAll(filteredList);

    return _person;
  }
  Future<List<Task>> getAlltasksbydate({String? date}) async {

    final taskdb   = Hive.box<Task>("task");
    List<Task> _person = [];
    print('tasks... ${taskdb.values}');

    final personList = taskdb.values.toList().cast<Task>();

    final filteredList = personList.where((task) => task.date == date).toList();
    _person.clear();
    _person.addAll(filteredList);

    return _person;
  }
  Future<List<Task>> getAlltasksbytype({String? type}) async {

    final taskdb   = Hive.box<Task>("task");
    List<Task> _person = [];
    print('tasks... ${taskdb.values}');

    final personList = taskdb.values.toList().cast<Task>();

    final filteredList = personList.where((task) => task.repeat_type == type).toList();
    _person.clear();
    _person.addAll(filteredList);

    return _person;
  }








  Future<void>updatedata({required int index, required Task data})async{
    final persondb = await Hive.box<Task>('task');
    persondb.putAt(index??0, data);
  }

  Future<void>deletetask({required int index})async{
    print('index... ${index}');
    final persondb = await Hive.box<Task>('task');
    persondb.deleteAt(index);
  }


}