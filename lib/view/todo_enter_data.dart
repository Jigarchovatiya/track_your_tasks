import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/res/common/app_text_field.dart';
import 'package:todo_app/res/constant/app_colors.dart';
import 'package:todo_app/res/constant/app_string.dart';
import 'package:todo_app/res/extensions/extensions.dart';

import '../data/model/to_do_model.dart';

class TodoEnterData extends StatefulWidget {
  final ToDoModel? toDoModel;
  final int? index;
  const TodoEnterData({
    Key? key,
    this.toDoModel,
    this.index,
  }) : super(key: key);
  @override
  State<TodoEnterData> createState() => _TodoEnterDataState();
}

class _TodoEnterDataState extends State<TodoEnterData> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String time = "";

  SharedPreferences? sharedPreferences;
  List<String> toDoList = [];

  setInstant() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getData();
  }

  getData() {
    if (sharedPreferences!.containsKey("ToDoData")) {
      toDoList = sharedPreferences!.getStringList("ToDoData")!;
      setState(() {});
    } else {
      debugPrint("No Data Found...");
    }
  }

  setData() {
    Map<String, dynamic> data = {
      "title": titleController.text,
      "description": descriptionController.text,
      "time": time,
    };
    if (widget.toDoModel != null) {
      toDoList[widget.index!] = (jsonEncode(data));
    } else {
      toDoList.add(jsonEncode(data));
    }

    sharedPreferences!.setStringList("ToDoData", toDoList);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    setInstant();

    if (widget.toDoModel != null) {
      titleController.text = widget.toDoModel!.title!;
      descriptionController.text = widget.toDoModel!.description!;
      time = widget.toDoModel!.time!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Add Task",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 80,
            horizontal: MediaQuery.of(context).size.height / 70,
          ),
          child: Form(
            onChanged: () {
              setState(() {});
            },
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(15),
              children: [
                AppTextField(
                  validator: (value) => value!.isValidName() ? null : "Please Enter Title",
                  hintText: 'Enter Title',
                  controller: titleController,
                  minAndMaxLine: null,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                AppTextField(
                  hintText: 'Description',
                  minAndMaxLine: 10,
                  controller: descriptionController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.materialColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time.isNotEmpty ? time : AppString.selectedTime,
                        style: TextStyle(
                          color: time.isNotEmpty ? Colors.black : Colors.grey.shade700,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.alarm),
                          onPressed: () async {
                            TimeOfDay? selectTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectTime != null) {
                              debugPrint(selectTime.format(context));
                              time = selectTime.format(context);
                              setState(() {});
                            }
                          }),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 15,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      backgroundColor: MaterialStatePropertyAll(AppColors.materialColor),
                    ),
                    onPressed: () {
                      setData();
                    },
                    child: const Text("Add Task"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
