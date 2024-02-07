import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/screen/addscreen.dart';
import 'package:todo_app_bloc/screen/update_screen.dart';

import '../bloc/todo_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is NavigateToAddTodoPage) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddScreen(),
              ),
            );
          } else if (state is NavigateToUpdateTodoPage) {
            final todoToUpdate = state.todo;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateScreen(
                  todo: todoToUpdate,
                ),
              ),
            );
          } else if (state is TodoErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.msg)));
          }
        },
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoLoadedState) {
            if (state.todos.length == 0) {
              return Center(
                child: Text('No Todos'),
              );
            } else {
              return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        todoBloc.add(
                            GotoUpdateScreenEvent(todo: state.todos[index]));
                      },
                      title: Text(state.todos[index].title),
                      subtitle: Text(state.todos[index].description),
                      trailing: IconButton(
                        onPressed: () {
                          todoBloc
                              .add(DeleteTodoEvent(id: state.todos[index].id!));
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      leading: Image.memory(
                        state.todos[index].imageBytes,
                        width: 50,
                        height: 50,
                      ),
                    );
                  });
            }
          } else if (state is TodoErrorState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoBloc.add(FloatingActionbuttonClicked());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
