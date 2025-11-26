part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  // Используем VideoCard, сгенерированный Drift'ом
  final List<VideoCard> videoCards;
  HomeLoaded(this.videoCards);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}