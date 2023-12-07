import 'package:equatable/equatable.dart';
// import 'package:pos_flutter/features/donation/model/user_model.dart';

import '../../domain/model/user_model.dart';

abstract class UserState extends Equatable {
  final UserModel? userModel;
  final String? success;
  const UserState({this.userModel, this.success});
  @override
  List<Object?> get props => [this.userModel];
}

class InitialUserState extends UserState {
  const InitialUserState();
}

class SuccessCreateUser extends UserState {
  final String success;
  const SuccessCreateUser(this.success);
}

class ErrorCreateUser extends UserState {
  final String error;
  const ErrorCreateUser(this.error);
}

class LoadingUserState extends UserState {
  const LoadingUserState();
}

class SuccessGetListUser extends UserState {
  final List<UserModel> listUser;

  SuccessGetListUser(this.listUser);
}

class SuccessGetUser extends UserState {
  final UserModel user;

  SuccessGetUser(this.user) : super(userModel: user);
}

class SuccessUpdateUser extends UserState {
  const SuccessUpdateUser();
}

class LoadingGetListUser extends UserState {
  const LoadingGetListUser();
}

class LoadingCreateUser extends UserState {
  const LoadingCreateUser();
}

class LoadingUpdateUser extends UserState {
  const LoadingUpdateUser();
}

class LoadingGetUserAdmin extends UserState {
  const LoadingGetUserAdmin();
}

class SuccessGetUserAdmin extends UserState {
  final UserModel admin;

  const SuccessGetUserAdmin(this.admin);
}
