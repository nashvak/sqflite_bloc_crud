part of 'todo_bloc.dart';

abstract class TodoEvent {
  const TodoEvent();
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;
  const AddTodoEvent({required this.todo});
}

class UpdateTodoEvent extends TodoEvent {
  final int index;
  const UpdateTodoEvent({required this.index});
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;
  const DeleteTodoEvent({required this.todo});
}
