import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:todo_best/extensions/space_exs.dart';
import 'package:todo_best/main.dart';
import 'package:todo_best/models/task.dart';
import 'package:todo_best/utils/app_colors.dart';
import 'package:todo_best/utils/app_str.dart';
import 'package:todo_best/utils/constants.dart';
import 'package:todo_best/views/home/components/fab.dart';
import 'package:todo_best/views/home/components/home_app_bar.dart';
import 'package:todo_best/views/home/components/slider_drawer.dart';
import 'package:todo_best/views/home/widgets/task_widget.dart';
import 'package:lottie/lottie.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey= GlobalKey<SliderDrawerState>();
  dynamic valueOfIndicator(List<Task> task){
    if(task.isNotEmpty){
      return task.length;
    }else{
      return 3;
    }
  }
  int checkDoneTask(List<Task> tasks){
    int i=0;
    for(Task doneTask in tasks){
      if(doneTask.isCompleted){
        i++;
      }
    }
    return i;
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;
    final base=BaseWidget.of(context);
    return ValueListenableBuilder(
        valueListenable: base.dataStire.listenToTask(),
        builder: (ctx,Box<Task> box,Widget? child){
          var tasks=box.values.toList();
          tasks.sort((a,b)=>a.createdAtDate.compareTo(b.createdAtDate));
           return Scaffold(
           backgroundColor: Colors.white,
           floatingActionButton: const Fab(),
            body: SliderDrawer(
            key: drawerKey,
            isDraggable:false,
            animationDuration: 1000,
            slider: CustomDrawer(),
            appBar: HomeAppBar(drawerKey: drawerKey,),
            child: _buildHomeBody(textTheme, height,base,tasks)),
            );
        });
  }

  Widget _buildHomeBody(TextTheme textTheme, double height,BaseWidget base,List<Task> tasks) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primaryColor),
                    ),
                  ),
                  25.w,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStr.mainTitle,
                        style: textTheme.displayLarge,
                      ),
                      3.h,
                      Text(
                        "${checkDoneTask(tasks)} of ${tasks.length} task",
                        style: textTheme.titleMedium,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Divider(
                thickness: 2,
                indent: 100,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: height * 0.70,
              child: tasks.isNotEmpty?ListView.builder(
                  itemCount: tasks.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var task=tasks[index];
                    return Dismissible(
                        onDismissed: (_) {
                          base.dataStire.daleteTask(task: task);
                        },
                        background:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
                            8.w,
        
                            const Text(AppStr.deletedTask,style: TextStyle(
                              color: Colors.grey
                            ),)
                          ],
                        ),
                        direction: DismissDirection.horizontal,
                        key: Key(task.id),
                        child: TaskWidget(task: task));
                  }):Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeIn(
                    child: SizedBox(
                      width:200,
                      height: 200,
                      child: Lottie.asset(lottieURL,
                      animate: tasks.isNotEmpty? false:true),
                    ),
                  ),
                  FadeInUp(
                    from: 30,
                      child: const Text(AppStr.doneAllTask))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
