class Tasks {
  Tasks({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<TasksData> data;

  Tasks.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => TasksData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class TasksData {
  TasksData({
    required this.taskId,
    required this.taskTitle,
    required this.taskDescription,
  });
  late final int taskId;
  late final String taskTitle;
  late final String taskDescription;

  TasksData.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskTitle = json['task_title'];
    taskDescription = json['task_description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['task_id'] = taskId;
    _data['task_title'] = taskTitle;
    _data['task_description'] = taskDescription;

    return _data;
  }
}
