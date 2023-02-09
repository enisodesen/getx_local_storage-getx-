// To parse this JSON data, do
//
//     final taskListModel = taskListModelFromJson(jsonString);

import 'dart:convert';

TaskListModel taskListModelFromJson(String str) =>
    TaskListModel.fromJson(json.decode(str));

String taskListModelToJson(TaskListModel data) => json.encode(data.toJson());

class TaskListModel {
  TaskListModel({
    this.taskList,
  });

  List<Task>? taskList;

  factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
        taskList: json["taskList"] == null
            ? []
            : List<Task>.from(json["taskList"]!.map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "taskList": taskList == null
            ? []
            : List<dynamic>.from(taskList!.map((x) => x.toJson())),
      };
}

class Task {
  Task({
    this.taskName,
    this.taskCompleted,
  });

  String? taskName;
  bool? taskCompleted;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskName: json["taskName"],
        taskCompleted: json["taskCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "taskName": taskName,
        "taskCompleted": taskCompleted,
      };
}
