part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class LoadTodoEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  AddTodoEvent({required this.todo});
}

class UpdateButtonClickedEvent extends TodoEvent {
  final Todo todo;

  UpdateButtonClickedEvent({required this.todo});
}

class DeleteTodoEvent extends TodoEvent {
  final int id;

  DeleteTodoEvent({required this.id});
}

class FloatingActionbuttonClicked extends TodoEvent {}

class GotoUpdateScreenEvent extends TodoEvent {
  final Todo todo;

  GotoUpdateScreenEvent({required this.todo});
}
