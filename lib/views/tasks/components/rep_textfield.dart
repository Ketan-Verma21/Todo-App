import 'package:flutter/material.dart';
import 'package:todo_best/utils/app_str.dart';
class RepTextField extends StatelessWidget {
  const RepTextField({
    super.key,
    required this.controller, this.isForDescription=false,required this.onFieldSubmitted,required this.onChanged,
  });

  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool isForDescription;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: !isForDescription? 3:null,
          cursorHeight: !isForDescription?30:null,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: isForDescription?InputBorder.none:null,
            counter: Container(),
            hintText: isForDescription? AppStr.addNote:null,
            prefixIcon: isForDescription?const Icon(
              Icons.bookmark_border,
              color: Colors.grey,
            ):null,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey.shade200
                )
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey.shade200
                )
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}