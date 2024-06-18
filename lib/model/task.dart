
import 'package:hive/hive.dart';
part 'task.g.dart';
@HiveType(typeId:0)
class Task{
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? time;
  @HiveField(2)
  String? repeat_type;
  @HiveField(3)
  String? date;

  Task(this.title, this.time, this.repeat_type, this.date);
}