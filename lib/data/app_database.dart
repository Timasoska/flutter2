import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';

// Указываем файл, который будет сгенерирован build_runner'ом.
// В нем содержится вся "магия" Drift: SQL-запросы, маппинг данных и класс _$AppDatabase.
part 'app_database.g.dart';

// 1. Описание структуры таблицы.
// Мы не пишем SQL вручную (CREATE TABLE...), Drift делает это за нас на основе этого класса.
class VideoCards extends Table {
  // autoIncrement автоматически создает уникальный ID для каждой записи
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
}

// 2. Основной класс базы данных.
@lazySingleton // АННОТАЦИЯ DI: Говорит GetIt'у: "Создай этот объект один раз, когда он впервые понадобится".
@DriftDatabase(tables: [VideoCards]) // Подключаем наши таблицы
class AppDatabase extends _$AppDatabase {
  // Конструктор открывает соединение с файлом базы данных
  AppDatabase() : super(_openConnection());

  // Версия схемы БД. Если мы изменим таблицы, нужно будет увеличить версию и написать миграцию.
  @override
  int get schemaVersion => 1;

  // 3. Стратегия миграции. Здесь мы определяем, что делать при создании БД.
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      // Создаем все таблицы в базе данных
      await m.createAll();

      // SEED DATA (Начальные данные):
      // Добавляем записи при самом первом запуске, чтобы экран не был пустым.
      await batch((batch) {
        batch.insertAll(videoCards, [
          VideoCardsCompanion.insert(
            name: 'GeForce RTX 4090',
            description: 'Флагманская модель от NVIDIA для 4K-гейминга.',
            imageUrl: 'https://www.nvidia.com/content/dam/en-zz/Solutions/geforce/ada/rtx-4090/geforce-rtx-4090-web-partner-card-307-d.jpg',
          ),
          VideoCardsCompanion.insert(
            name: 'Radeon RX 7900 XTX',
            description: 'Топовое решение от AMD на архитектуре RDNA 3.',
            imageUrl: 'https://www.amd.com/system/files/2022-11/1723521-amd-radeon-rx-7900-series-angle-1260x709.png',
          ),
          VideoCardsCompanion.insert(
            name: 'GeForce RTX 4070',
            description: 'Сбалансированная карта для 2K-гейминга.',
            imageUrl: 'https://i0.wp.com/www.overclockers.com/wp-content/uploads/2022/11/card3-scaled.jpg?ssl=1',
          ),
        ]);
      });
    },
  );
}

// Вспомогательная функция для поиска пути к файлу БД на устройстве (Windows/Android/iOS)
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    // База будет лежать в файле 'videocards_db.sqlite' в документах приложения
    return driftDatabase(
      name: 'videocards_db',
      native: DriftNativeOptions(
        databaseDirectory: () async => dbFolder,
      ),
    );
  });
}