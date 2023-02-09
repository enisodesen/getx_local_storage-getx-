// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:getx_local_storage/getx_files/controller.dart';
import 'package:getx_local_storage/widgets/list_tile.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TaskController controller = Get.put(TaskController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TO DOS LIST'),
      ),
      body: (controller.taskListModel.value.taskList!.isEmpty)
          ? const Center(
              child: Text(
              'Add Some Tasks',
              style: TextStyle(fontSize: 20),
            ))
          : Obx(
              () => ListView.builder(
                  itemCount: controller.taskListModel.value.taskList!.length,
                  itemBuilder: (context, index) => ToDoTile(
                        index: index,
                        text: textController.text,
                        taskCompleted: false,
                        deleteTask: (context) {
                          controller.deleteTask(
                              task: controller
                                  .taskListModel.value.taskList![index]);
                        },
                      )),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(color: Colors.orange.shade100),
                    width: size.width / 2,
                    child: TextField(
                      controller: textController,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    )),
              ],
            ),
            title: 'Add a Task',
            backgroundColor: Colors.orange.shade200,
            textCancel: 'Cancel',
            cancelTextColor: Colors.white,
            textConfirm: 'Add',
            confirmTextColor: Colors.white,
            onConfirm: () {
              controller.addTask(textController.text, false);
              textController.clear();
              Navigator.of(context).pop();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
