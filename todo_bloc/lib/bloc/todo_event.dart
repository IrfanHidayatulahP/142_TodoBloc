part of 'todo_bloc.dart';

sealed class TodoEvent {}

final class TodoBlocEventAdd extends TodoEvent {
  final String title;
  final DateTime date;
  bool isCompleted = false;

  TodoBlocEventAdd({
    required this.title,
    required this.date,
    this.isCompleted = false,
    });
}

final class TodoEventComplete extends TodoEvent {
  final int index;

  TodoEventComplete({
    required this.index,
  });
}

final class TodoSelectedDate extends TodoEvent {
  final DateTime date;

  TodoSelectedDate({
    required this.date,
  });
}