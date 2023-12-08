
import 'package:flutter_bloc/flutter_bloc.dart';
part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState()) {
    on<Trigger>((event, emit) {
      emit(WelcomeState(index: event.index));
    });
  }
}
