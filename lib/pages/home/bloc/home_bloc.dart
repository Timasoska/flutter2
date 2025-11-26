import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter2/data/app_database.dart';
import 'package:flutter2/data/video_cards_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final VideoCardsRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<LoadVideoCardsEvent>(_onLoadVideoCards);
    on<AddVideoCardEvent>(_onAddVideoCard);       // <-- Новый
    on<UpdateVideoCardEvent>(_onUpdateVideoCard); // <-- Новый
    on<DeleteVideoCardEvent>(_onDeleteVideoCard); // <-- Новый
  }

  Future<void> _onLoadVideoCards(
      LoadVideoCardsEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading());
    try {
      final cards = await repository.getAllVideoCards();
      emit(HomeLoaded(cards)); // Даже если список пуст, показываем Loaded (пустой список)
    } catch (e) {
      emit(HomeError("Ошибка загрузки: $e"));
    }
  }

  Future<void> _onAddVideoCard(
      AddVideoCardEvent event,
      Emitter<HomeState> emit,
      ) async {
    try {
      await repository.addVideoCard(event.card);
      add(LoadVideoCardsEvent()); // Перезагружаем список
    } catch (e) {
      emit(HomeError("Ошибка добавления: $e"));
    }
  }

  Future<void> _onUpdateVideoCard(
      UpdateVideoCardEvent event,
      Emitter<HomeState> emit,
      ) async {
    try {
      await repository.updateVideoCard(event.card);
      add(LoadVideoCardsEvent()); // Перезагружаем список
    } catch (e) {
      emit(HomeError("Ошибка обновления: $e"));
    }
  }

  Future<void> _onDeleteVideoCard(
      DeleteVideoCardEvent event,
      Emitter<HomeState> emit,
      ) async {
    try {
      await repository.deleteVideoCard(event.id);
      add(LoadVideoCardsEvent()); // Перезагружаем список
    } catch (e) {
      emit(HomeError("Ошибка удаления: $e"));
    }
  }
}