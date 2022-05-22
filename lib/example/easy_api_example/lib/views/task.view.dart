import '../models/todo.model.dart';
import '../repository/todo.network.dart';
import '../repository/todo.repository.dart';
import 'package:flutter/material.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskRepository taskRepository =
        TaskRepository(taskNetwork: TaskNetwork(baseApiUrl: "YOUR_URL"));

    return Scaffold(
      body: FutureBuilder(
          future: taskRepository.fetchTasks(),
          builder: (context, snapshot) {
            List<TasksData> data = snapshot.data as List<TasksData>;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(data[index].taskTitle),
                );
              },
            );
          }),
    );
  }
}
