import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import 'app_database.dart';

// АННОТАЦИЯ DI: Регистрируем репозиторий в системе внедрения зависимостей.
@lazySingleton
class VideoCardsRepository {
  final AppDatabase _db;

  // Конструктор.
  // Injectable автоматически найдет созданный ранее экземпляр AppDatabase и подставит сюда.
  VideoCardsRepository(this._db);

  // Метод для получения списка карт.
  // Возвращает Future<List<VideoCard>>, где VideoCard — это дата-класс, сгенерированный Drift'ом.
  Future<List<VideoCard>> getAllVideoCards() async {
    // Эмуляция задержки сети (чтобы мы успели увидеть крутилку загрузки)
    await Future.delayed(const Duration(seconds: 1));

    // Обращение к таблице videoCards через select-запрос
    return _db.select(_db.videoCards).get();
  }
}