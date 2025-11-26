import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter2/data/app_database.dart'; // Импорт сгенерированной модели VideoCard
import 'package:flutter2/data/video_cards_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable // Помечаем Блок как injectable, чтобы DI мог его создать
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final VideoCardsRepository repository;

  // Injectable сам найдет и подставит репозиторий
  HomeBloc(this.repository) : super(HomeInitial()) {
    on<LoadVideoCardsEvent>(_onLoadVideoCards);
  }

  Future<void> _onLoadVideoCards(
      LoadVideoCardsEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading());

    try {
      // Получаем данные из БД через репозиторий
      final cards = await repository.getAllVideoCards();

      if (cards.isEmpty) {
        emit(HomeError("Список видеокарт пуст (БД пуста)!"));
      } else {
        emit(HomeLoaded(cards));
      }
    } catch (e) {
      emit(HomeError("Ошибка загрузки: $e"));
    }
  }
}