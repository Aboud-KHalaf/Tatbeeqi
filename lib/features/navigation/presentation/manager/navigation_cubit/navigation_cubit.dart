import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationInitial());

  void changeIndex(int index) {
    emit(NavigationIndexChanged(index));
  }
}
