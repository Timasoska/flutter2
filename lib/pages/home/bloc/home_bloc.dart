import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter2/data/video_cards_data.dart';
import 'package:flutter2/models/video_card.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadVideoCardsEvent>(_onLoadVideoCards);
  }

  Future<void> _onLoadVideoCards(
      LoadVideoCardsEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading()); // 1. Сообщаем UI, что грузимся

    try {
      // 2. Имитация задержки сети (2 секунды)
      await Future.delayed(const Duration(seconds: 2));

      // 3. Если список пуст - можно кинуть ошибку для проверки state Error
      if (mockVideoCards.isEmpty) {
        emit(HomeError("Список видеокарт пуст!"));
      } else {
        // 4. Передаем данные в UI
        emit(HomeLoaded(mockVideoCards));
      }
    } catch (e) {
      emit(HomeError("Ошибка загрузки данных"));
    }
  }
}