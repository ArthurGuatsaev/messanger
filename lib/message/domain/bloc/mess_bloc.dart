import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mess_event.dart';
part 'mess_state.dart';

class MessBloc extends Bloc<MessEvent, MessState> {
  MessBloc() : super(MessInitial()) {
    on<MessEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
