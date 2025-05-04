import 'package:get_it/get_it.dart';
import 'package:unstudio_assignment/repository/api_calls.dart';

final GetIt locatorDI = GetIt.instance;


//dependancy injection classes are lazy registered here----
void initializeLocationDI() {
  locatorDI.registerLazySingleton<ApiCalls>(
    () => ApiCalls(),
  );
}
