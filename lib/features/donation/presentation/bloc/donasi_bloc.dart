import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/donation/domain/service/donation_service.dart';
import 'package:pos_flutter/features/donation/model/donasi_model.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_state.dart';

class DonasiBloc extends Cubit<DonasiState> {
  DonationService donationService = DonationService();
  DonasiBloc() : super(const InitialDonasiState());

  Future<void> createDonasi(DonasiModel donasiModel) async {
    emit(LoadingDonasiState());
    var response = await donationService.createDonasiService(donasiModel);

    response?.fold(
        (l) => emit(SuccessCreateDonasi('Successfully created donasi')),
        (r) => print(r));
  }

  void getListDonasi() async {
    emit(LoadingDonasiState());
    var response = await donationService.getListDonasiService();

    print('get list donasi response' + response.toString());
    response?.fold((l) => emit(SuccessGetListDonasi(l)), (r) => print(r));
  }
}
