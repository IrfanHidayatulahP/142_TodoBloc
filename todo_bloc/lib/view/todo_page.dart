import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    final _controller = TextEditingController();
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
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context, 
                          firstDate: DateTime(2000), 
                          lastDate: DateTime(2100),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            context.read<TodoBloc>().add(
                              TodoSelectedDate(date: selectedDate),
                            );
                          }
                        });
                      }, child: const Text('Select Date'),
                    )
                  )
                ],
              ),
              Form(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          labelText: 'Todo',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a todo';
                          }
                          return null;
                        },
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          final selectedDate = context.read<TodoBloc>().state;
                          if (selectedDate is TodoLoaded) {
                            context.read<TodoBloc>().add(
                              TodoBlocEventAdd(
                                title: _controller.text, 
                                date: selectedDate.selectedDate!,
                              ),
                            );
                          }
                        }
                      }, 
                      child: const Text('Add Todo')
                    )
                  ],
                )
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: BlocBuilder<TodoBloc, TodoState>(
                  builder: (context, state) {
                    if (state is TodoLoaded) {
                      return const Center(child: CircularProgressIndicator(),);
                    } else if (state is TodoLoaded) {
                      if (state.todos.isEmpty) {
                        return const Center(child: Text('Todo list is Empty'));
                      }
                      return ListView.builder(
                        itemCount: state.todos.length,
                        itemBuilder: (context, index) {
                          final todo = state.todos[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todo.title,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      '${todo.date.day}/${todo.date.month}/${todo.date.year}',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      todo.isCompleted ? 'Completed' : 'Not Completed',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  value: todo.isCompleted,
                                  onChanged: (value) {
                                    context.read<TodoBloc>().add(
                                      TodoEventComplete(index: index),
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'No todos available',
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}