import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo_app_bloc/models/models.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<AddTodoEvent>(addTodoFunction);
    on<UpdateTodoEvent>(updateTodoFunction);
    on<DeleteTodoEvent>(deleteTodoFunction);
  }

  FutureOr<void> addTodoFunction(AddTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;
    emit(TodoState(
      allTodos: List.from(state.allTodos)..add(event.todo),
    ));
  }

  FutureOr<void> updateTodoFunction(
      UpdateTodoEvent event, Emitter<TodoState> emit) {}

  FutureOr<void> deleteTodoFunction(
      DeleteTodoEvent event, Emitter<TodoState> emit) {}
}
