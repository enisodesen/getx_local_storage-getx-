import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_local_storage/getx_files/tasklist_model.dart';

class TaskController extends GetxController {
  var dataBase = TaskListModel().obs;
  final box = GetStorage();
  static const taskListTag = 'dataBase';

  void saveTaskList({required TaskListModel newTaskList}) {
    box.write(taskListTag, newTaskList.toJson());
    var json = box.read(taskListTag);
    dataBase.value = TaskListModel.fromJson(json);
    print('Veri tabani güncellendi');
  }

  var taskListModel = TaskListModel(taskList: <Task>[]).obs;

  @override
  void onInit() {
    super.onInit();
    if (box.read(taskListTag) != null) {
      var json = box.read(taskListTag);
      taskListModel.value = TaskListModel.fromJson(json);
    }
  }

  void addTask(String taskName, bool taskCompleted) {
    taskListModel.value.taskList!
        .add(Task(taskName: taskName, taskCompleted: taskCompleted));
    saveTaskList(newTaskList: taskListModel.value);
  }

  void deleteTask({required Task task}) {
    taskListModel.value.taskList!.remove(task);
    taskListModel.refresh();
    saveTaskList(newTaskList: taskListModel.value);
  }
}
