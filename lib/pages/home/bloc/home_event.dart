part of 'home_bloc.dart';

abstract class HomeEvent {}

// Загрузка (уже была)
class LoadVideoCardsEvent extends HomeEvent {}

// Добавление
class AddVideoCardEvent extends HomeEvent {
  final VideoCard card;
  AddVideoCardEvent(this.card);
}

// Обновление
class UpdateVideoCardEvent extends HomeEvent {
  final VideoCard card;
  UpdateVideoCardEvent(this.card);
}

// Удаление
class DeleteVideoCardEvent extends HomeEvent {
  final int id;
  DeleteVideoCardEvent(this.id);
}