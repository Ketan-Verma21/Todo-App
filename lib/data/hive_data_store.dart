import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_best/models/task.dart';

class HiveDataStire{
  static const boxName='taskBox';
  final Box<Task> box= Hive.box<Task>(boxName);
  Future<void> addTask({required Task task})async{
    await box.put(task.id,task);
  }
  Future<Task?> getTask({required String id})async{
    return box.get(id);
  }
  Future<void> updateTask({required Task task})async{
    await task.save();
  }
  Future<void> daleteTask({required Task task})async{
    await task.delete();
  }
  ValueListenable<Box<Task>> listenToTask()=>box.listenable();
}