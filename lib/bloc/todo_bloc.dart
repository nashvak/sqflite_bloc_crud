import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_bloc/db_helper.dart';
import 'package:todo_app_bloc/models/models.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  TodoBloc() : super(TodoInitialState()) {
    on<AddTodoEvent>(addTodoFunction);
    on<LoadTodoEvent>(loadTodoFunction);
    on<UpdateButtonClickedEvent>(updateTodoFunction);
    on<DeleteTodoEvent>(deleteTodoFunction);
    on<FloatingActionbuttonClicked>(navigateToAddTodoPageFunction);
    on<GotoUpdateScreenEvent>(navigateToupdateTodoPageFunction);
  }

  FutureOr<void> addTodoFunction(
      AddTodoEvent event, Emitter<TodoState> emit) async {
    print(event.todo.description);
    emit(TodoLoadingState());
    try {
      await databaseHelper.insertTodo(event.todo);

      final List<Todo> todos = await databaseHelper.getTodos();
      emit(TodoLoadedState(todos: todos));
    } catch (e) {
      emit(TodoErrorState(msg: e.toString()));
    }
  }

  FutureOr<void> loadTodoFunction(
      LoadTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      final List<Todo> todos = await databaseHelper.getTodos();
      emit(TodoLoadedState(todos: todos));
    } catch (e) {
      emit(TodoErrorState(msg: e.toString()));
    }
  }

  FutureOr<void> updateTodoFunction(
      UpdateButtonClickedEvent event, Emitter<TodoState> emit) async {
    try {
      // print(event.todo.title);
      // print(event.todo.description);
      await databaseHelper.updateTodo(event.todo);
      final List<Todo> todos = await databaseHelper.getTodos();
      emit(TodoLoadedState(todos: todos));
    } catch (e) {
      emit(TodoErrorState(msg: e.toString()));
    }
  }

  FutureOr<void> deleteTodoFunction(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    try {
      await databaseHelper.deleteTodo(event.id);
      final List<Todo> todos = await databaseHelper.getTodos();
      emit(TodoLoadedState(todos: todos));
    } catch (e) {
      emit(TodoErrorState(msg: e.toString()));
    }
  }

  //  navigation

  FutureOr<void> navigateToupdateTodoPageFunction(
      GotoUpdateScreenEvent event, Emitter<TodoState> emit) {
    emit(NavigateToUpdateTodoPage(todo: event.todo));
  }

  FutureOr<void> navigateToAddTodoPageFunction(
      FloatingActionbuttonClicked event, Emitter<TodoState> emit) {
    emit(NavigateToAddTodoPage());
  }

  //
}
//conflict algorithm means if the data already exists , then it replace with new todo