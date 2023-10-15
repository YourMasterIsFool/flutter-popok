import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/donation/domain/service/donation_service.dart';
import 'package:pos_flutter/features/donation/model/donasi_model.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_state.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_state.dart';

class DonasiBloc extends Cubit<DonasiState> {
  DonationService donationService = DonationService();
  DonasiBloc() : super(const InitialDonasiState());

  Future<void> createDonasi(DonasiModel donasiModel) async {
    emit(LoadingCreateDonasi());
    var response = await donationService.createDonasiService(donasiModel);

    response?.fold((l) {
      emit(SuccessCreateDonasi('Successfully created donasi'));
      getListDonasi();
    }, (r) => print(r));
  }

  void getListDonasi({
    Map<String, dynamic>? params,
  }) async {
    emit(LoadingDonasiState());
    var response = await donationService.getListDonasiService(params: params);

    print('get list donasi response' + response.toString());
    response?.fold((l) => emit(SuccessGetListDonasi(l)), (r) => print(r));
  }

  Future<void> getDetailDonasiBloc(int? id) async {
    emit(LoadingGetDetailDonasi());
    var response = await donationService.getDetailDonasiService(id);

    response?.fold((l) {
      emit(SuccessGetDetailDonasi(l));
    }, (r) {});
  }

  Future<void> updateDonasi(DonasiModel donasiModel, int? id) async {
    emit(LoadingCreateDonasi());
    var response = await donationService.updateDonasiService(id, donasiModel);

    response?.fold((l) {
      emit(SuccessCreateDonasi('Successfully created donasi'));
      getListDonasi();
    }, (r) => print(r));
  }

  Future<void> updateStatusDonasi(int id, int status) async {
    emit(LoadingUpdateStatus());
    var response = await donationService.updateStatusDonasi(id, status);

    response?.fold((l) {
      emit(SuccessUpdateStatus());
      getListDonasi();
    }, (r) {});
  }
}
