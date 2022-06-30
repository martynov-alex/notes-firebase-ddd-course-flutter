import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:notes_firebase_ddd_course/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: false, // default
  asExtension: false, // default
)
void configureInjection(String env) => $initGetIt(getIt, environment: env);
