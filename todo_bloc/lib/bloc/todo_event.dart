part of 'todo_bloc.dart';

sealed class TodoEvent {}

final class TodoBlocEventAdd extends TodoEvent {
  final String title;
  final DateTime date;

  TodoBlocEventAdd({
    required this.title,
    required this.date,
    });
}