// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:getx_local_storage/getx_files/controller.dart';
import 'package:get/get.dart';

class ToDoTile extends StatelessWidget {
  ToDoTile(
      {super.key,
      required this.text,
      required this.taskCompleted,
      required this.deleteTask,
      required this.index});

  final String text;
  final bool? taskCompleted;
  final void Function(BuildContext)? deleteTask;
  final TaskController controller = Get.find();
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Slidable(
          endActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.red,
            ),
          ]),
          child: Obx(
            () => Container(
              decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(12)),
              height: 70,
              child: Row(
                children: [
                  Checkbox(
                    onChanged: (value) {
                      controller.taskListModel.value.taskList![index]
                          .taskCompleted = value;
                      controller.taskListModel
                          .refresh(); // içindeki bir değer değiştiği için refresh komutunu kullanmamız gerekiyor.
                      controller.saveTaskList(
                          newTaskList: controller.taskListModel.value);
                    },
                    value: controller
                        .taskListModel.value.taskList![index].taskCompleted,
                    activeColor: Colors.black,
                  ),
                  Text(
                    controller.taskListModel.value.taskList![index].taskName!,
                    style: TextStyle(
                        fontSize: 20,
                        decoration: controller.taskListModel.value
                                .taskList![index].taskCompleted!
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
