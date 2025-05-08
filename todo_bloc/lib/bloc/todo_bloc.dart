import 'package:bloc/bloc.dart';
import 'package:todo_bloc/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoaded(todos: [], selectedDate: null)) {
    on<TodoBlocEventAdd>((event, emit) {
      final currentState = state;
      if (currentState is TodoLoaded) {
        final List<Todo> updatedtodos = List.from(currentState.todos);
        updatedtodos.add(
          Todo(
            title: event.title,
            date: event.date,
            isCompleted: false,
          ),
        );
        emit(
          TodoLoaded(
            todos: updatedtodos,
            selectedDate: currentState.selectedDate,
          ),
        );
      }
    });

    on<TodoSelectedDate>((event, emit) {
      final currentState = state;
      if (currentState is TodoLoaded) {
        emit(
          TodoLoaded(
            todos: currentState.todos, 
            selectedDate: event.date
          )
        );
      }
    });

    on<TodoEventComplete>((event, emit) {
      final currentState = state;
      if (currentState is TodoLoaded) {
        final List<Todo> updatedTodos = List.from(currentState.todos);
        if (event.index >= 0 && event.index < updatedTodos.length) {
          updatedTodos[event.index] = Todo(
            title: updatedTodos[event.index].title,
            date: updatedTodos[event.index].date,
            isCompleted: updatedTodos[event.index].isCompleted == true,
          );
        }
        emit(
          TodoLoaded(
            todos: updatedTodos,
            selectedDate: currentState.selectedDate,
          ),
        );
      }
    });
  }
}
