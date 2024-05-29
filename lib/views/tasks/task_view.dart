import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';
import 'package:todo_best/extensions/space_exs.dart';
import 'package:todo_best/main.dart';
import 'package:todo_best/models/task.dart';
import 'package:todo_best/utils/app_colors.dart';
import 'package:todo_best/utils/app_str.dart';
import 'package:todo_best/utils/constants.dart';
import 'package:todo_best/views/tasks/components/date_time_selection.dart';
import 'package:todo_best/views/tasks/components/rep_textfield.dart';
import 'package:todo_best/views/tasks/widgets/task_view_app_bar.dart';
class TaskView extends StatefulWidget {
  TaskView({Key? key, required this.titleTaskController, required this.descriptionTaskController,required this.task}) : super(key: key);
  TextEditingController? titleTaskController ;
  TextEditingController? descriptionTaskController;
  final Task? task;
  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;
  String showTime(DateTime? time){
    if(widget.task?.createdAtTime==null){
      if(time==null){
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      }
      else{
        return DateFormat('hh:mm a').format(time).toString();
      }
    }
    else{
      return DateFormat('hh:mm a').format(widget.task!.createdAtTime).toString();
    }
  }
  String showDate(DateTime ? date){
    if(widget.task?.createdAtDate==null){
      if(date==null){
        return DateFormat('dd:MM:yyyy').format(DateTime.now()).toString();
      }
      else{
        return DateFormat('dd:MM:yyyy').format(date).toString();
      }
    }else{
      return DateFormat('dd:MM:yyyy').format(widget.task!.createdAtDate).toString();
    }
  }
  DateTime showDateAsDateTime(DateTime? date){
    if(widget.task?.createdAtDate==null){
        if(date==null){
          return DateTime.now();
        }
        else{
          return date;
        }
    }
    else{
      return widget.task!.createdAtDate;
    }
  }
  bool isTaskAlreadyExist(){
    if(widget.titleTaskController?.text==null &&
        widget.descriptionTaskController?.text==null ){
      return true;
    }
    else{
      // widget.titleTaskController=TextEditingController();
      return false;
    }
  }
  dynamic isTaskAlreadyExistUpdateOtherWiseCreate(){
    if(widget.titleTaskController?.text!=null &&
    widget.descriptionTaskController?.text!=null){
      try{
        widget.titleTaskController?.text=title;
        widget.descriptionTaskController?.text=subTitle;
        widget.task?.save();
        Navigator.pop(context);
      }
      catch(e){
          updateTaskWarning(context);
      }
    }
    else{
      if(title!=null && subTitle!=null){
        var task=Task.create(
            title: title,
            subTitle: subTitle,
            createdAtDate: date,
            createdAtTime: time
        );
        BaseWidget.of(context).dataStire.addTask(task: task);
        Navigator.pop(context);
      }
      else{
        emptyWarning(context);
      }
    }
  }
  dynamic deleteTask(){
    return widget.task?.delete();
  }
  @override
  Widget build(BuildContext context) {
    var textTheme=Theme.of(context).textTheme;
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: const TaskViewAppBar(),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopSideTexts(textTheme),
                _buildMainTaskViewActivity(textTheme, context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
                width: double.infinity,
                height: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:30.0),
                      child: Text(AppStr.titleOfTitleTextField,
                      style: textTheme.headlineMedium,),
                    ),
                    RepTextField(
                      controller: widget.titleTaskController,
                      onFieldSubmitted: (String inputTitle) {
                        title=inputTitle;
                      },
                      onChanged: (String inputTitle) {
                        title=inputTitle;
                      },),
                    10.h,
                    RepTextField(
                        controller: widget.descriptionTaskController,
                      isForDescription: true,
                      onChanged: (String inputSubTitle) {
                          subTitle=inputSubTitle;
                      },
                      onFieldSubmitted: (String inputSubTitle) {
                          subTitle=inputSubTitle;
                      },
                    ),
                    DateTimeSelectionWidget(onTap:  (){
                      showModalBottomSheet(context: context, builder: (_)=>SizedBox(
                        height: 258,
                        child: TimePickerWidget(
                          onChange: (_,__){},
                          initDateTime: showDateAsDateTime(time),
                          dateFormat: 'HH:mm',
                          onConfirm: (dateTime,_){
                              setState(() {
                                if(widget.task?.createdAtTime==null){
                                  time=dateTime ;
                                }
                                else{
                                  widget.task?.createdAtTime=dateTime;
                                }
                              });
                          },
                        ),
                      ));
                    }, title: AppStr.timeString, time: showTime(time),),
                    DateTimeSelectionWidget(onTap:  (){
                      DatePicker.showDatePicker(context,
                      maxDateTime: DateTime(2030,4,5),
                        minDateTime: DateTime.now(),
                        onConfirm: (dateTime,_){
                          setState(() {
                            if(widget.task?.createdAtDate==null){
                              date=dateTime;
                            }
                            else{
                              widget.task?.createdAtDate=dateTime;
                            }
                          });
                        },
                      );
                    }, title: AppStr.dateString, time:showDate(date),),
                    100.h,
                    _buildBottomSideButtons(),
                  ],
                ),
              );
  }

  Widget _buildBottomSideButtons() {
    return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: isTaskAlreadyExist()?MainAxisAlignment.center:MainAxisAlignment.spaceEvenly,
                      children: [

                        if(!isTaskAlreadyExist())MaterialButton(onPressed: (){
                          deleteTask();
                          Navigator.pop(context);
                        },
                        minWidth: 150,
                        height: 55,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(Icons.close,color: AppColors.primaryColor,),
                            5.w,
                            Text(AppStr.deleteTask,
                            style: TextStyle(
                              color: AppColors.primaryColor
                            ),),
                          ],
                        ),),
                        MaterialButton(onPressed: (){
                          isTaskAlreadyExistUpdateOtherWiseCreate();
                          // Navigator.pop(context);
                        },
                          minWidth: 150,
                          height: 55,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          color: AppColors.primaryColor,
                          child: Text(isTaskAlreadyExist()?
                            AppStr.addTaskString:AppStr.updateTaskString,
                            style: TextStyle(
                                color: Colors.white
                            ),),),
                      ],
                    ),
                  );
  }

  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 50,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                RichText(text: TextSpan(
                  text: isTaskAlreadyExist()?AppStr.addNewTask:AppStr.updateCurrentTask,
                  style: textTheme.titleLarge,
                  children: const [
                     TextSpan(
                      text: AppStr.taskStrnig,
                      style: TextStyle(
                        fontWeight: FontWeight.w400
                      ),

                    )
                  ]
                )),
               const SizedBox(
                  width: 50,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ],
            ),
          );
  }
}




