import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import 'app_database.dart';

@lazySingleton
class VideoCardsRepository {
  final AppDatabase _db;

  VideoCardsRepository(this._db);

  // READ
  Future<List<VideoCard>> getAllVideoCards() async {
    // Сортируем, чтобы новые были внизу (или по ID)
    return (_db.select(_db.videoCards)
      ..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .get();
  }

  // CREATE
  Future<void> addVideoCard(VideoCard card) async {
    // Превращаем обычный объект в Companion для вставки.
    // ID не указываем, Drift сгенерирует его сам.
    await _db.into(_db.videoCards).insert(
      VideoCardsCompanion.insert(
        name: card.name,
        description: card.description,
        imageUrl: card.imageUrl,
      ),
    );
  }

  // UPDATE
  Future<void> updateVideoCard(VideoCard card) async {
    // replace заменяет всю строку по её ID
    await _db.update(_db.videoCards).replace(card);
  }

  // DELETE
  Future<void> deleteVideoCard(int id) async {
    // Удаляем запись, где id совпадает
    await (_db.delete(_db.videoCards)..where((t) => t.id.equals(id))).go();
  }
}