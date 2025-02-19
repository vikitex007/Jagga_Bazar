import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dasboard_event.dart';
part 'dasboard_state.dart';

class DasboardBloc extends Bloc<DasboardEvent, DasboardState> {
  DasboardBloc() : super(DasboardInitial()) {
    on<DasboardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
