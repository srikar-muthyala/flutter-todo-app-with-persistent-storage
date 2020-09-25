class Todo {
  final int id;
  final int taskID;
  final String title;
  final int isDone;
  Todo({this.id, this.isDone, this.title, this.taskID});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskID': taskID,
      'title': title,
      'isDone': isDone,
    };
  }
}
