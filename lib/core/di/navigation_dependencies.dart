import 'package:get_it/get_it.dart';
import 'package:tatbeeqi/features/navigation/presentation/manager/navigation_cubit/navigation_cubit.dart';

final sl = GetIt.instance;

void initNavigationDependencies(GetIt sl) {
  // --- Navigation Feature ---
  // Manager (Cubit) - Register as Factory because its state is simple and UI-specific
  sl.registerFactory(() => NavigationCubit());
}
