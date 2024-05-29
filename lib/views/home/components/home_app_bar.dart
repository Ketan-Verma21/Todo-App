import 'dart:developer';

import 'package:feedback/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todo_best/main.dart';
import 'package:todo_best/utils/constants.dart';
class HomeAppBar extends StatefulWidget {
  const HomeAppBar({Key? key, required this.drawerKey}) : super(key: key);
  final GlobalKey<SliderDrawerState> drawerKey;
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> with SingleTickerProviderStateMixin{
  late AnimationController animateController;
  bool isDrawerOpen=false;
  @override
  void initState() {
    // TODO: implement initState
    animateController=AnimationController(vsync: this,
    duration: Duration(seconds: 1));
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animateController.dispose();
    super.dispose();
  }

  void onDrawerToggle(){
    setState(() {
      isDrawerOpen=!isDrawerOpen;
      if(isDrawerOpen){
        animateController.forward();
        widget.drawerKey.currentState!.openSlider();
      }
      else{
        animateController.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }
  void submitFeedback(BuildContext context){
    BetterFeedback.of(context).show((UserFeedback feedback)async {
        log("feedback pressed");
    });
  }
  @override
  Widget build(BuildContext context) {
    var base=BaseWidget.of(context).dataStire.box;
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(onPressed: onDrawerToggle, icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close, progress: animateController,
                size: 30,

              )),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(onPressed: (){
                      submitFeedback(context);

                  }
                      , icon: Icon(
                        Icons.bug_report_outlined,
                        size: 30,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(onPressed: (){
                    base.isEmpty? noTaskWarning(context):deleteAllTask(context);
                  }
                  , icon: Icon(
                    CupertinoIcons.trash_fill,
                    size: 30,
                  )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
