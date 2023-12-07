import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_state.dart';
import 'package:pos_flutter/features/donation/domain/service/donation_service.dart';
import 'package:pos_flutter/features/donation/model/donasi_model.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_state.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_state.dart';

import '../../domain/model/user_model.dart';
import '../../domain/service/user_service.dart';

class UserBloc extends Cubit<UserState> {
  UserService donationService = UserService();
  UserBloc() : super(const InitialUserState());

  Future<void> getCurrentUser() async {
    emit(LoadingUserState());
    var response = await donationService.get_current_user_service();

    print('get list donasi response' + response.toString());
    response?.fold((l) => emit(SuccessGetUser(l)), (r) => print(r));
  }

  Future<void> registerNewUser(UserModel schema) async {
    emit(LoadingCreateUser());
    var response = await donationService.registerNewUserService(schema);

    response?.fold((l) {
      emit(SuccessCreateUser('Success create kurir'));
    }, (r) {
      emit(ErrorCreateUser(r.response!.data.toString()));
    });
  }

  Future<void> updateName(String name) async {
    emit(LoadingUpdateUser());

    print('name' + name);
    var response = await donationService.update_user_service({'name': name});

    response?.fold((l) {
      emit(SuccessUpdateUser());

      getCurrentUser();
    }, (r) => null);
  }

  Future<void> updateEmail(String email) async {
    emit(LoadingUpdateUser());

    var response = await donationService.update_user_service({'email': email});

    response?.fold((l) {
      emit(SuccessUpdateUser());
      getCurrentUser();
    }, (r) => null);
  }

  Future<void> updateUserBio({required Map<String, dynamic> schema}) async {
    print("schema update user bio" + schema.toString());
    var response = await donationService.update_user_service(schema);
    emit(LoadingUpdateUser());
    response?.fold((l) {
      emit(SuccessUpdateUser());
      getCurrentUser();
    }, (r) => null);
  }

  Future<void> getListKurir() async {
    emit(LoadingGetListUser());
    var response =
        await donationService.getListKurir(params: {'role': 'kurir'});

    response?.fold((l) {
      print('list kurir' + l.toString());
      emit(SuccessGetListUser(l));
    }, (r) {});
  }

  Future<void> getUserAdminBloc() async {
    emit(LoadingGetUserAdmin());
    var response = await UserService().get_user_admin();

    response?.fold((l) {
      emit(SuccessGetUserAdmin(l));
    }, (r) {});
  }
}
