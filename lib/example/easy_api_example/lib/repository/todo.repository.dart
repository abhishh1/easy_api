import 'package:easy_api/easy_api.dart';
import '../models/todo.model.dart';
import './todo.network.dart';

class TaskRepository extends EasyModelWrapper {
  final TaskNetwork taskNetwork;
  TaskRepository({required this.taskNetwork});

  Future createTask({
    required String taskTitle,
    required String taskDescription,
    required String taskScheduledAt,
    required List<int> taskCategoryIds,
  }) async {
    return decoder(
        response: await taskNetwork.createTask(
            taskTitle: taskTitle, taskDescription: taskDescription));
  }

  Future fetchTasks() async {
    return nestedModelDecoder(
        jsonFormat: Tasks.fromJson,
        parentTypeClass: Tasks,
        childTypeClass: TasksData,
        response: await taskNetwork.fetchTask());
  }
}
