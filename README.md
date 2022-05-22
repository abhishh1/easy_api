# ⚡Easy API

## Best and easy way to INTEGRATE REST API WITH FLUTTER😎

Main features of `easy_api` : 

1. `Performing HTTP requests🚀`
2. `Handling HTTP Exceptions🚀`
3. `Data model handling🚀`

`Video tutorial` : https://youtu.be/63NKUl067v8

## 🎖Installing

```yaml
dependencies:
  easy_api: ^<latest_version>
```

## Usage

## a. Performing HTTP requests🚀

#### 0. Extend your network class with `EasyApiHandler`.

```
class MyNetworkClass extends EasyApiHelper {

 // default constructor needs to be provided.
 
  MyNetworkClass({required String baseApiUrl})
      : super(baseApiUrl: "http://localhost:5000/", headers: "YOUR_CUSTOM_HEADERS");
      
   Note : headers paramater is optional. In case of null header, easy_api will use default headers as below
   
     {
       'Content-type': 'application/json',
       'Accept': 'application/json',
       'Access-Control-Allow-Origin": "*"
     };
      
}
```

#### 1. Send get request with `sendGetRequest` function.


```
class MyNetworkClass extends EasyApiHelper {

  MyNetworkClass({required String baseApiUrl})
      : super(baseApiUrl: "http://localhost:5000/");
      
  Future fetchTask() async {
    return sendGetRequest(route: "todo/fetch");
  }
  
  Future fetchTaskWithParameters(int task_id) async {
    return sendGetRequest(route: "todo/fetch_by_id", params : task_id);
  }
  
}

```

#### 2. Send post request with `sendPostRequest` function.

```
class MyNetworkClass extends EasyApiHelper {

  MyNetworkClass({required String baseApiUrl})
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
  
}

```

#### 3. Send delete request with `sendDeleteRequest` function.

```
class MyNetworkClass extends EasyApiHelper {

  MyNetworkClass({required String baseApiUrl})
      : super(baseApiUrl: "http://localhost:5000/");
      
  Future deleteTask({
    required int taskId
  }) async {
    return sendDeleteRequest(route: "todo/delete", // required
            params : taskId.toString(), // required
            isParams : true, // required
            body : {SOME_BODY} // optioal
         ); 
  }
  
}

```


#### 4. Send put request with `sendPutRequest` function.

```
class MyNetworkClass extends EasyApiHelper {

  MyNetworkClass({required String baseApiUrl})
      : super(baseApiUrl: "http://localhost:5000/");
      
  Future updateTask({
    required int taskId,
    required String taskTitle
  }) async {
    
    return sendPutRequest(
          route: "todo/update", // required
          body : { "taskId" : taskId, "taskTitle" : taskTitle} // required
          );
  }
  
}

```

## b. Handling HTTP Exceptions🚀

The `EasyException` class will handle all the exceptions.

```
Future updateTask({
    required int taskId,
    required String taskTitle
  }) async {
    
   try{
   
     return sendPutRequest(
          route: "todo/update",
          body : { "taskId" : taskId, "taskTitle" : taskTitle} 
       );
     }
     on EasyException catch (exception){
     
     debugPrint(exception.message)
     
     // Additionally show snackbar to user
     
     }
  }

```

## c. Data model handling🚀

Extend your repository class with `EasyModelWrapper` and see the easy magic🚀

The `EasyModelWrapper` provides 3 functions which can be used to parse (encode/decode) data from data models.


Note : At this version release, The data model must have prime paramter of `status` and `data` as the output. Else you will have to cast the property names.

Demo model class : 

```

class Tasks {
  Tasks({
    required this.status, //  REQUIRED💥
    required this.data, // REQUIRED💥
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


```

Usage of `EasyModelWrapper` : 

```

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
  
  Future fetchSimpleTasks() async {
    return modelDecoder(
        jsonFormat: Tasks.fromJson,
        parentTypeClass: Tasks,
        response: await taskNetwork.fetchTask());
  }

  Future fetchNestedTasks() async {
    return nestedModelDecoder(
        jsonFormat: Tasks.fromJson,
        parentTypeClass: Tasks,
        childTypeClass: TasksData,
        response: await taskNetwork.fetchTask());
  }
}

```

-----------------------------------------------------------------------------


#### ❤Loved the utility? [Donate here](https://www.paypal.com/paypalme/abhishvekk).
#### 🚀Want to learn more about Flutter? [Checkout this out!](https://www.youtube.com/channel/UCIxJGxcB4pSrIvuv8FyuqUA)
#### 💥DM me on Instagram for doubts [Follow here](https://www.instagram.com/abhishvek/)

## 🐛 Bugs/Requests

If you encounter any problems feel free to open an issue. If you feel the library is
missing a feature, please raise a ticket on Github and I'll look into it.
Pull request are also welcome.