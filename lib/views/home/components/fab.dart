import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_best/utils/app_colors.dart';
import 'package:todo_best/views/tasks/task_view.dart';
class Fab extends StatelessWidget {
  const Fab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>  TaskView(titleTaskController: null, descriptionTaskController: null, task: null,)));
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}