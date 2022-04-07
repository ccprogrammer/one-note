class TodoControler {
  // SET CONTROLLER
  var noteList = [];

  void addTodo(id, todo, description) {
    noteList.add({
      'id': id,
      'todo': todo,
      'description': description,
    });
  }

  void deleteTodo(id) {
    noteList.removeWhere((element) => element['id'] == id);
  }
}
