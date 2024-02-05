part of 'todo_bloc.dart';

class TodoState {
  final List<Todo> allTodos;
  const TodoState({this.allTodos = const <Todo>[]});
}

class TodoInitial extends TodoState {}
