import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    final _titleController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Todo List'),
              Row(
                children: [
                  Column(
                    children: [
                      const Text('Select Date'),
                      BlocBuilder<TodoBloc, TodoState>(
                        builder: (context, state) {
                          if (state is TodoLoaded) {
                            if (state is TodoLoaded) {
                              if (state.selectedDate != null) {
                                return Text(
                                  '${state.selectedDate!.day}/${state.selectedDate!.month}/${state.selectedDate!.year}',
                                );
                              }
                            }
                          }
                          return const Text('No date selected');
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}