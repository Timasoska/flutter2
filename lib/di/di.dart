import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
// Этот файл генерируется автоматически командой build_runner
import 'di.config.dart';

// Глобальный экземпляр GetIt (наш сервис-локатор / контейнер зависимостей)
final getIt = GetIt.instance;

// АННОТАЦИЯ: Говорит генератору кода создать функцию init()
@InjectableInit()
void configureDependencies() => getIt.init(); // Инициализация всех зависимостей