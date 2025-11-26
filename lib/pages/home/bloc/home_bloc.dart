import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter2/data/app_database.dart';
import 'package:flutter2/data/video_cards_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

// АННОТАЦИЯ: Делаем Блок доступным для DI.
// Теперь мы можем получить его через getIt<HomeBloc>().
@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {

  // Блок зависит от Репозитория. Мы НЕ создаем репозиторий тут (new Repository).
  // Мы получаем его извне (Inversion of Control).
  final VideoCardsRepository repository;

  // Injectable сам "впрыснет" (inject) сюда нужный репозиторий.
  HomeBloc(this.repository) : super(HomeInitial()) {
    // Регистрируем обработчик события загрузки
    on<LoadVideoCardsEvent>(_onLoadVideoCards);
  }

  Future<void> _onLoadVideoCards(
      LoadVideoCardsEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading()); // 1. Сообщаем UI: "Покажи загрузку"

    try {
      // 2. Обращаемся к репозиторию за данными
      final cards = await repository.getAllVideoCards();

      if (cards.isEmpty) {
        emit(HomeError("Список видеокарт пуст (БД пуста)!"));
      } else {
        // 3. Передаем успешный результат в UI
        emit(HomeLoaded(cards));
      }
    } catch (e) {
      emit(HomeError("Ошибка загрузки: $e"));
    }
  }
}