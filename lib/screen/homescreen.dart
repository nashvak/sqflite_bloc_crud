import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/screen/addscreen.dart';

import '../bloc/todo_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                      title: Text(state.todos[index].title),
                      subtitle: Text(state.todos[index].description),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
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
