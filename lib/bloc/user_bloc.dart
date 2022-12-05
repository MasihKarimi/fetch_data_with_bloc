import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fetch_data_from_api_with_bloc/models/User.dart';
import 'package:fetch_data_from_api_with_bloc/repos/repositories.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // call to repository
  final UserRepository _repository;
  UserBloc(this._repository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      // pass the loaded data to the view
      try {
        final users = await _repository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserLoadingErrorState(e.toString()));
      }
    });
  }
}
