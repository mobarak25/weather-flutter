import 'package:get_it/get_it.dart';
import 'package:weather/core/injection/ingection.config.dart';

final getIt = GetIt.instance;

void configureDependencies() => $initGetIt(getIt);
