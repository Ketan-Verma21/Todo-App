import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_best/extensions/space_exs.dart';
import 'package:todo_best/utils/app_colors.dart';
class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final List<IconData> icons=[
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill
  ];
  final List<String> texts=[
    "Home",
    "Profile",
    "Settings",
    "Details"
  ];
  @override
  Widget build(BuildContext context) {
    var textTheme=Theme.of(context).textTheme;
    return Container(
      padding:const  EdgeInsets.symmetric(vertical: 90),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: AppColors.primaryGradientColor,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight)
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.black,
            backgroundImage: AssetImage("assets/img/2.jpg"),
          ),
          8.h,
          Text("Ketan Verma",style: textTheme.displayMedium,),
          Text("Flutter dev",style: textTheme.displaySmall,),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: icons.length,
                itemBuilder: (context,index){
              return InkWell(
                onTap: (){},
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                      leading: Icon(icons[index],color: Colors.white,size: 30,),
                    title: Text(texts[index],style:const  TextStyle(
                      color: Colors.white
                    ),),
                  ),
                ),
              );
            }),

          )
        ],
      ),
    );
  }
}
