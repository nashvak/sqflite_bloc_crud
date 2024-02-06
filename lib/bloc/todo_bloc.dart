import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_bloc/db_helper.dart';
import 'package:todo_app_bloc/models/models.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  TodoBloc() : super(TodoInitialState()) {
    on<AddTodoEvent>(addTodoFunction);
    on<LoadTodoEvent>(loadTodoFunction);
    on<UpdateTodoEvent>(updateTodoFunction);
    on<DeleteTodoEvent>(deleteTodoFunction);
    on<FloatingActionbuttonClicked>(navigateToAddTodoPageFunction);
    on<UpdateButtonClickEvent>(navigateToupdateTodoPageFunction);
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
      UpdateTodoEvent event, Emitter<TodoState> emit) {}

  FutureOr<void> deleteTodoFunction(
      DeleteTodoEvent event, Emitter<TodoState> emit) {}

  //  navigation

  FutureOr<void> navigateToupdateTodoPageFunction(
      UpdateButtonClickEvent event, Emitter<TodoState> emit) {
    emit(NavigateToUpdateTodoPage());
  }

  FutureOr<void> navigateToAddTodoPageFunction(
      FloatingActionbuttonClicked event, Emitter<TodoState> emit) {
    emit(NavigateToAddTodoPage());
  }

  //

  // Future<void> updateTodo(Todo todo) async {
  //   final Database db = await database;
  //   await db.update(
  //     'todos',
  //     todo.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [todo.id],
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // Future<void> deleteTodo(int id) async {
  //   final Database db = await database;
  //   await db.delete(
  //     'todos',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }
}
//conflict algorithm means if the data already exists , then it replace with new todo