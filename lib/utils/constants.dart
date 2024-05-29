import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todo_best/main.dart';
import 'package:todo_best/utils/app_str.dart';

String lottieURL ='assets/lottie/1.json';
dynamic emptyWarning(BuildContext context){
  return FToast.toast(context,
    msg: AppStr.oopsMsg,
    subMsg: 'You Must fill all fields',
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20)
  );
}
dynamic updateTaskWarning(BuildContext context){
  return FToast.toast(context,
      msg: AppStr.oopsMsg,
      subMsg: 'You must edit the tasks then try to update it!',
      corner: 20.0,
      duration: 5000,
      padding: const EdgeInsets.all(20)
  );
}
dynamic noTaskWarning(BuildContext context){
  return PanaraInfoDialog.showAnimatedGrow(context,
      title: AppStr.oopsMsg,
      message: "There is no Task For Delete!\n Try adding some and then try to delete it!",
      buttonText: "Okay",
      onTapDismiss: (){
        Navigator.pop(context);

      },
      panaraDialogType: PanaraDialogType.warning);
}
dynamic deleteAllTask(BuildContext context){
  return PanaraConfirmDialog.show(
      context,
      title: AppStr.areYouSure,
      message: "Do You really want to delete all tasks? You will no be able to undo this action!",
      panaraDialogType: PanaraDialogType.error,
      confirmButtonText: "Yes",
      cancelButtonText: "No",
      onTapConfirm: () {
        BaseWidget.of(context).dataStire.box.clear();
        Navigator.of(context);
      },
      onTapCancel: () {
        Navigator.pop(context);
      });
}