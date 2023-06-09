import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/res/constant/app_colors.dart';
import 'package:todo_app/res/constant/app_string.dart';
import 'package:todo_app/view/to_do_enter_data.dart';
import 'package:todo_app/view/to_do_tile.dart';

import '../data/model/to_do_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? sharedPreferences;

  List<ToDoModel> toDoModel = [];

  setInstant() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getData();
  }

  getData() {
    toDoModel = [];
    if (sharedPreferences!.containsKey('ToDoData')) {
      var data = sharedPreferences!.getStringList("ToDoData");

      for (var mapData in data!) {
        toDoModel.add(toDoModelFromJson(mapData));
      }
      debugPrint(data.toString());
      debugPrint(jsonEncode(toDoModel));
      setState(() {});
    } else {
      debugPrint("No Data Foud----------->>");
    }
  }

  setData() {
    List<String> listData = [];
    for (var mapData in toDoModel) {
      listData.add(jsonEncode(mapData));
    }

    sharedPreferences!.setStringList("ToDoData", listData);
  }

  @override
  void initState() {
    // TODO: implement initState
    setInstant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: const Text(AppString.homePageTitle),
        leading: const Icon(Icons.menu),
      ),
      body: toDoModel.isEmpty
          ? const Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: toDoModel.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  title: toDoModel[index].title,
                  time: toDoModel[index].time,
                  description: toDoModel[index].description,
                  count: (index + 1).toString(),
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoEnterData(
                          toDoModel: toDoModel[index],
                          index: index,
                        ),
                      ),
                    ).then((value) {
                      getData();
                    });
                  },
                  onDelete: () {
                    toDoModel.removeAt(index);
                    setState(() {});
                    setData();
                  },
                );
              },
              // separatorBuilder: (context, index) => SizedBox(
              //   height: MediaQuery.of(context).size.height / 150,
              // ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.materialColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TodoEnterData(),
            ),
          ).then((value) {
            getData();
          });
        },
        child: const Icon(Icons.add, size: 30),
      ),
      backgroundColor: Colors.white,
    );
  }
}
