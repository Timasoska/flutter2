import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';

// Указываем имя файла, который будет сгенерирован
part 'app_database.g.dart';

// 1. Описание таблицы
class VideoCards extends Table {
  // id - автоинкремент
  IntColumn get id => integer().autoIncrement()();
  // Название видеокарты
  TextColumn get name => text()();
  // Описание
  TextColumn get description => text()();
  // Ссылка на картинку
  TextColumn get imageUrl => text()();
}

// 2. Класс базы данных
@lazySingleton // Регистрируем БД как Singleton в DI
@DriftDatabase(tables: [VideoCards])
class AppDatabase extends _$AppDatabase {
  // Конструктор, открывающий соединение
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // 3. Миграция и начальное заполнение данными (Seed)
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll(); // Создаем таблицы

      // Добавляем начальные данные (CRUD - Create)
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

// Функция открытия соединения (стандартный код для drift_flutter)
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    // Имя файла базы данных
    return driftDatabase(
      name: 'videocards_db',
      native: DriftNativeOptions(
        databaseDirectory: () async => dbFolder,
      ),
    );
  });
}