import 'package:easy_api/easy_api.dart';

class TaskNetwork extends EasyApiHelper {
  TaskNetwork({required String baseApiUrl})
      : super(baseApiUrl: "http://localhost:5000/");

  Future createTask({
    required String taskTitle,
    required String taskDescription,
  }) async {
    return sendPostRequest(route: "todo/create", body: {
      "task_title": taskTitle,
      "task_description": taskDescription,
    });
  }

  Future fetchTask() async {
    return sendGetRequest(route: "todo/fetch");
  }
}
