import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_best/data/hive_data_store.dart';
import 'package:todo_best/models/task.dart';
import 'package:todo_best/utils/app_colors.dart';
import 'package:todo_best/views/home/home_view.dart';
import 'package:todo_best/views/tasks/task_view.dart';

Future<void> main() async{
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  Box box=await Hive.openBox<Task>(HiveDataStire.boxName);
  box.values.forEach((task) {
    if(task.createdAtTime.day !=DateTime.now()){
      task.delete();
    }
    else{

    }
  });
  runApp(BaseWidget(child: BetterFeedback(
    theme:FeedbackThemeData(
      activeFeedbackModeColor: AppColors.primaryColor,
      background: Colors.lightBlueAccent,
      drawColors: [
        Colors.green,
        Colors.yellow,
        Colors.black,
        Colors.red
      ]
    ),

      child: const MyApp())));
}
class BaseWidget extends InheritedWidget{
  BaseWidget({Key? key,required this.child}):super(key:key,child: child);
  final HiveDataStire dataStire = HiveDataStire();
  final Widget child;
  static BaseWidget of(BuildContext context){
    final base =context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if(base!=null){
      return base;
    }else{
      throw StateError("Could not find ancestor widget of type BaseWidget");
    }

  }
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slim Shady',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          headline2: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
          headline3: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headline4: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          headline5: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          subtitle2: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          headline6: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      home: HomeView(),
    );
  }
}

