import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart'; // Этот файл будет сгенерирован

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();