import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/res/constant/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final int? minAndMaxLine;
  final FormFieldValidator<String>? validator;

  AppTextField({Key? key, this.controller, required this.hintText, required this.minAndMaxLine, this.validator}) : super(key: key);
  final TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return TextFormField(
      validator: validator,
      controller: titleController,
      minLines: minAndMaxLine,
      maxLines: minAndMaxLine,
      autofocus: true,
      style: TextStyle(
        color: CupertinoColors.black,
        fontWeight: FontWeight.w400,
        fontSize: height / 60,
        fontStyle: FontStyle.normal,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.materialColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.materialColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        hintText: hintText ?? "",
        filled: true,
        fillColor: const Color(0xffFFFFFF),
      ),
    );
  }
}
