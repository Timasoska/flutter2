part of 'home_bloc.dart';

abstract class HomeState {}

// Initial: начальное состояние
class HomeInitial extends HomeState {}

// Loading: идет загрузка
class HomeLoading extends HomeState {}

// Loaded: данные успешно загружены
class HomeLoaded extends HomeState {
  final List<VideoCard> videoCards;
  HomeLoaded(this.videoCards);
}

// Error: произошла ошибка
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}