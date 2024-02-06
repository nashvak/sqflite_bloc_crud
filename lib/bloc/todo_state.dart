part of 'todo_bloc.dart';

abstract class TodoState {}

abstract class TodoActionState extends TodoState {}

class TodoInitialState extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<Todo> todos;

  TodoLoadedState({required this.todos});
}

class TodoErrorState extends TodoState {
  final String msg;

  TodoErrorState({required this.msg});
}

//
class NavigateToAddTodoPage extends TodoActionState {}

class NavigateToUpdateTodoPage extends TodoActionState {}
