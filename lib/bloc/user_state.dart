part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

// initial state before loading data
class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

// data loaded state
class UserLoadedState extends UserState {
  const UserLoadedState(this.users);
  final List<UserModel> users;

  @override
  List<Object> get props => [users];
}

// error in loading data state
class UserLoadingErrorState extends UserState {
  const UserLoadingErrorState(this.errorMessage);
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}
