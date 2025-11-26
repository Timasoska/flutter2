import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart'; // Для ordering (опционально)
import 'app_database.dart';

@lazySingleton // Регистрируем репозиторий в DI
class VideoCardsRepository {
  final AppDatabase _db;

  // Injectable сам подставит сюда экземпляр AppDatabase
  VideoCardsRepository(this._db);

  // Метод получения всех карт (CRUD - Read)
  // VideoCard - это класс данных, который сгенерирует Drift
  Future<List<VideoCard>> getAllVideoCards() async {
    // Имитация задержки сети, как в прошлой практике
    await Future.delayed(const Duration(seconds: 1));

    return _db.select(_db.videoCards).get();
  }
}